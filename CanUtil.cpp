#include "CanUtil.h"
#include <QTimer>

CanUtil::CanUtil()
{
    this->start();

    QTimer* timer = new QTimer();

    timer->setInterval(200);
    timer->setSingleShot(false);
    connect(timer,&QTimer::timeout,this,[=](){
       auto speed = rand()/100.0;
       emit  signalSpeed(speed);
    });
    timer->start(100);
}

CanUtil::~CanUtil()
{
    this->quit();
    this->wait();
}

void CanUtil::showData(VcuMsg *msg)
{
    std::cout << "Data handler ShowData()..." << std::endl;
}

void CanUtil::run()
{
    VcuClusterComp bcc;

    hb_ =[this](const void* srv_msg,void* user_arg)
    {
        VcuMsg* bat_msg = (VcuMsg*)srv_msg;
        showData(bat_msg);
        emit this->signalTest(bat_msg->speed());
    };

    void* arg1 = nullptr;
    bcc.Create();
    DataHandler* data_handler_ = new DataHandler(hb_,arg1);
    bcc.RegisterDataHandler(data_handler_);


    ServiceLifeCycle life;
    bcc.Consume(life);
    bcc.WaitForShutdown();
}
