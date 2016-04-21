#ifndef QQUICKAPPBUTTON_H
#define QQUICKAPPBUTTON_H

#include <QtLabsTemplates/private/qquicktoolbutton_p.h>

class QQuickAppButton : public QQuickToolButton
{
    Q_OBJECT

public:
    QQuickAppButton(QQuickItem *parent = Q_NULLPTR);
    virtual ~QQuickAppButton() {}

private slots:
    void onParentChanged(QQuickItem*);
    void delayedExecution();
};

#endif // QQUICKAPPBUTTON_H
