#include "qquickuaptitlebar.h"

#include <functional>
#include <QtCore/private/qeventdispatcher_winrt_p.h>
#include <QHash>

#if WINAPI_FAMILY_PARTITION(WINAPI_PARTITION_PHONE_APP) && _MSC_VER >= 1900
#include <windows.foundation.h>
#include <windows.ui.core.h>
#include <windows.ui.viewmanagement.h>

using namespace ABI::Windows::Foundation;
using namespace Microsoft::WRL;
using namespace Microsoft::WRL::Wrappers;

using namespace ABI::Windows::UI::Core;

typedef IEventHandler<BackRequestedEventArgs*> BackRequestedHandler;

typedef HRESULT (__stdcall ISystemNavigationManager::*SystemNavigationManagerCallbackRemover)(EventRegistrationToken);
uint qHash(SystemNavigationManagerCallbackRemover key) { void *ptr = *(void **)(&key); return qHash(ptr); }

#endif

class QQuickUapTitleBarPrivate
{
public:
    QQuickUapTitleBarPrivate()
        : m_visible(false)
        , m_componentCompleted(false) { }

    bool m_visible;
    QString m_error;
    bool m_componentCompleted;

#if WINAPI_FAMILY_PARTITION(WINAPI_PARTITION_PHONE_APP) && _MSC_VER >= 1900
    ComPtr<ABI::Windows::UI::ViewManagement::IApplicationView3> appView3;
    ComPtr<ABI::Windows::UI::ViewManagement::IApplicationViewTitleBar> appTitleBar;
    ComPtr<ABI::Windows::UI::Core::ISystemNavigationManager> systemNavigationManager;
    ComPtr<ABI::Windows::UI::Core::ISystemNavigationManager2> systemNavigationManager2;

    QHash<SystemNavigationManagerCallbackRemover, EventRegistrationToken> snmTokens;
#endif
};

QQuickUapTitleBar::QQuickUapTitleBar(QObject *parent)
    : QObject(parent), QQmlParserStatus()
    , d_ptr(new QQuickUapTitleBarPrivate)
{
}

QQuickUapTitleBar::~QQuickUapTitleBar()
{
#if WINAPI_FAMILY_PARTITION(WINAPI_PARTITION_PHONE_APP) && _MSC_VER >= 1900
    Q_D(QQuickUapTitleBar);

    HRESULT hr;
    for (QHash<SystemNavigationManagerCallbackRemover, EventRegistrationToken>::const_iterator i = d->snmTokens.begin(); i != d->snmTokens.end(); ++i) {
        hr = (d->systemNavigationManager.Get()->*i.key())(i.value());
    }
#endif
}

bool QQuickUapTitleBar::backButtonVisible() const
{
    Q_D(const QQuickUapTitleBar);
    return d->m_visible;
}

void QQuickUapTitleBar::setBackButtonVisible(bool visible)
{
    Q_D(QQuickUapTitleBar);

    if (visible == d->m_visible)
        return;

    d->m_visible = visible;

    if (d->m_componentCompleted)
        updateVisibility();
}

QString QQuickUapTitleBar::error() const
{
    Q_D(const QQuickUapTitleBar);
    return d->m_error;
}

void QQuickUapTitleBar::componentComplete()
{
#if WINAPI_FAMILY_PARTITION(WINAPI_PARTITION_PHONE_APP) && _MSC_VER >= 1900
    Q_D(QQuickUapTitleBar);

    if (true) {
        HRESULT hr;
        // get ApplicationView object
        ComPtr<ABI::Windows::UI::ViewManagement::IApplicationViewStatics2> applicationViewStatics;
        hr = RoGetActivationFactory(HString::MakeReference(RuntimeClass_Windows_UI_ViewManagement_ApplicationView).Get(),
                                    IID_PPV_ARGS(&applicationViewStatics));

        ComPtr<ABI::Windows::UI::ViewManagement::IApplicationView> view;
        hr = QEventDispatcherWinRT::runOnXamlThread([applicationViewStatics, &view]() {
            HRESULT hr;
            hr = applicationViewStatics->GetForCurrentView(&view);
            return hr;
        });

        // get TitleBar object
        hr = view.As(&d->appView3);
        hr = QEventDispatcherWinRT::runOnXamlThread([d]() {
            HRESULT hr;
            hr = d->appView3->get_TitleBar(&d->appTitleBar);
            return hr;
        });

        // get SystemNavigationManager objects
        ComPtr<ABI::Windows::UI::Core::ISystemNavigationManagerStatics> snmStatics;
        hr = RoGetActivationFactory(HString::MakeReference(RuntimeClass_Windows_UI_Core_SystemNavigationManager).Get(),
                                    IID_PPV_ARGS(&snmStatics));

        hr = QEventDispatcherWinRT::runOnXamlThread([snmStatics, &d]() {
            HRESULT hr;
            hr = snmStatics->GetForCurrentView(&d->systemNavigationManager);
            return hr;
        });
        d->systemNavigationManager.As(&d->systemNavigationManager2);


        // connect the handler
        hr = d->systemNavigationManager->add_BackRequested(Callback<BackRequestedHandler>(this, &QQuickUapTitleBar::onBackRequested).Get(),
                                       &d->snmTokens[&ISystemNavigationManager::remove_BackRequested]);

        updateVisibility();
    } else {
        d->m_error = QStringLiteral("the Windows 10 TitleBar is not supported on your platform!");
        emit errorChanged();
    }
#else
    m_error = QStringLiteral("the Windows 10 TitleBar is not supported on your platform!");
    emit errorChanged();
#endif

    d->m_componentCompleted = true;
}

void QQuickUapTitleBar::updateVisibility()
{
#if WINAPI_FAMILY_PARTITION(WINAPI_PARTITION_PHONE_APP) && _MSC_VER >= 1900
    Q_D(QQuickUapTitleBar);
    QEventDispatcherWinRT::runOnXamlThread([this, d]() {
        if (d->m_visible) {
            d->systemNavigationManager2->put_AppViewBackButtonVisibility(ABI::Windows::UI::Core::AppViewBackButtonVisibility_Visible);
        } else {
            d->systemNavigationManager2->put_AppViewBackButtonVisibility(ABI::Windows::UI::Core::AppViewBackButtonVisibility_Collapsed);
        }
        return S_OK;
    });
#endif
}

HRESULT QQuickUapTitleBar::onBackRequested(IInspectable *, ABI::Windows::UI::Core::IBackRequestedEventArgs *)
{
    emit backButtonPressed();
    return S_OK;
}
