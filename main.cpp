#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "CanUtil.h"
#include <functional>

int main(int argc, char *argv[])
{

#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);

   qmlRegisterType<CanUtil>("CanUtil",1,0,"CanUtil");
    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/qmlfiles/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
