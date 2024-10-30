#include "CanUtil.h"

CanUtil::CanUtil()
{
    this->start();
}

CanUtil::~CanUtil()
{
    this->quit();
    this->wait();
}

void CanUtil::run()
{
    BatteryClusterComp bcc;

    hb_ =[this](const void* arg1,void* arg2)
    {
        std::cout<<"arg1 is :"<<arg1<<"arg2 is :"<<arg2<<std::endl;
        emit this->signalTest(num_);
    };

    void* arg1 = nullptr;
    void* arg2 = nullptr;

    DataHandler* data_handler_ = new DataHandler(hb_,arg1,arg2);

    bcc.RegisterDataHandler(data_handler_);
    bcc.Create();

    ServiceLifeCycle life;
    bcc.Consume(life);
    bcc.WaitForShutdown();
}
