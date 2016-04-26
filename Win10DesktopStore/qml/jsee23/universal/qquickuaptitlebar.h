#ifndef QQUICKUAPTITLEBAR_H
#define QQUICKUAPTITLEBAR_H

#include <QObject>
#include <QtQml/QQmlParserStatus>

#include <wrl.h>

namespace ABI {
    namespace Windows {
        namespace UI {
            namespace Core {
                struct ISystemNavigationManager;
                struct IBackRequestedEventArgs;
            }
        }
    }
}
struct IInspectable;

class QQuickUapTitleBarPrivate;
class QQuickUapTitleBar : public QObject, public QQmlParserStatus
{
    Q_OBJECT
    Q_INTERFACES(QQmlParserStatus)

    Q_PROPERTY(bool backButtonVisible READ backButtonVisible WRITE setBackButtonVisible NOTIFY visibleChanged)

    Q_PROPERTY(QString error READ error NOTIFY errorChanged)

public:
    explicit QQuickUapTitleBar(QObject *parent = 0);
    ~QQuickUapTitleBar();

    bool backButtonVisible() const;
    void setBackButtonVisible(bool backButtonVisible);

    QString error() const;

    void classBegin() Q_DECL_OVERRIDE { }
    void componentComplete() Q_DECL_OVERRIDE;

signals:
    void visibleChanged();
    void errorChanged();

    void backButtonPressed();

private:
    void updateVisibility();

    HRESULT onBackRequested(IInspectable *, ABI::Windows::UI::Core::IBackRequestedEventArgs*);

    QQuickUapTitleBarPrivate* d_ptr;
    Q_DECLARE_PRIVATE(QQuickUapTitleBar)
};

#endif // QQUICKUAPTITLEBAR_H
