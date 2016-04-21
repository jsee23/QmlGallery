#include "qquickappbutton.h"

#include <QTimer>
#include <QtLabsTemplates/private/qquicktoolbar_p.h>

QQuickAppButton::QQuickAppButton(QQuickItem *parent)
    : QQuickToolButton(parent)
{
    connect(this, SIGNAL(parentChanged(QQuickItem*)),
            this, SLOT(onParentChanged(QQuickItem*)));
}

void QQuickAppButton::onParentChanged(QQuickItem* item)
{
    QQuickItem* parent = Q_NULLPTR;
    QQuickToolBar* toolbar = Q_NULLPTR;

    if (item)
        parent = item;
    else
        parent = parentItem();

    if (!parent)
        return;

    bool isRunning = true;
    for (int i=0; i < 5 && isRunning; i++) {
        toolbar = qobject_cast<QQuickToolBar*>(parent);
        if (toolbar) {
            setProperty("__appBar", QVariant::fromValue<QQuickToolBar*>(toolbar));
            isRunning = false;
        } else {
            parent = parent->parentItem();
            if (!parent || i == 5)
                isRunning = false;
        }
    }

    if (item)
        QTimer::singleShot(1000, this, SLOT(delayedExecution()));
}

void QQuickAppButton::delayedExecution()
{
    onParentChanged(Q_NULLPTR);
}
