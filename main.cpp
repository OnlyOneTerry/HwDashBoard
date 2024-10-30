#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "CanUtil.h"
#include <functional>

//#include "component/battery_cluster_comp/battery_cluster_comp.hpp"

//using namespace srvcomps;

//DataHandler* data_handler_ =nullptr;

int main(int argc, char *argv[])
{
//   BatteryClusterComp bcc;

//   HandlerCb func =[](const void* arg1,void* arg2)
//   {
//      std::cout<<"arg1 is :"<<arg1<<"arg2 is :"<<arg2<<std::endl;
//   };

//   void* arg1 = nullptr;
//   void* arg2 = nullptr;

//   data_handler_ = new DataHandler(func,arg1,arg2);

//   bcc.RegisterDataHandler(data_handler_);
//   bcc.Create();

//    ServiceLifeCycle life;
//    bcc.Consume(life);

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
