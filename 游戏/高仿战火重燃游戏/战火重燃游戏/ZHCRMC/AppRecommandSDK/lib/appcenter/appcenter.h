#ifndef __APPCENTER_H__
#define __APPCENTER_H__

#include "packethandler.h"
#include <string>

using namespace std;

class AppCenter
{
public:
    AppCenter();
    ~AppCenter();

public:

    bool init(unsigned int user_id, unsigned int app_id, unsigned int language_id);

    bool analyzeHandshakePkt(const unsigned char *buff, unsigned int bufflen);
    bool createHandshakePkt(unsigned char *buff, unsigned int max_buff_len, unsigned int *bufflen);

    bool analyzeQuestionPkt(const unsigned char *buff, unsigned int bufflen);
    bool createQuestionAnswerPkt(unsigned char *buff, unsigned int max_buff_len, unsigned int *bufflen);

    bool analyzeAuthorizedPkt(const unsigned char *buff, unsigned int bufflen);

    bool createReqAppCenterUpdateTime(unsigned char *buff, unsigned int max_buff_len, unsigned int *bufflen);
    bool analyzeAppCenterUpdateTime(const unsigned char *buff, unsigned int bufflen);
    bool createReqAppInfo(unsigned char *buff, unsigned int max_buff_len, unsigned int *bufflen);
    bool analyzeAppInfo(const unsigned char *buff, unsigned int bufflen);
    bool createReportDownloadSuccess(unsigned char *buff, unsigned int max_buff_len, unsigned int *bufflen, unsigned int downloaded_app);
    bool analyzeReportDownloadSuccessAck(const unsigned char *buff, unsigned int bufflen);

    bool getFileServerIp(unsigned char *buff, unsigned int max_buff_len, unsigned int *bufflen);
    bool getFileServerPort(unsigned int *port);

    bool getAppCenterUpdateTime(unsigned int *updatetime);

    bool getAppTotalApp(unsigned int *totalapp);
    bool getAppReceivedApp(unsigned int *received_app);

    bool getAppId(unsigned int index, unsigned int *appid);
    bool getAppUpdateTime(unsigned int index, unsigned int *updatetime);
    bool getAppSize(unsigned int index, unsigned int *appsize);
    bool getAppDisplaySequence(unsigned int index, unsigned int *seq);
    bool getAppLanguage(unsigned int index, unsigned int *language);
    bool getAppVersionStr(unsigned int index, unsigned char *buff, unsigned int max_buff_len, unsigned int *bufflen);
    bool getAppName(unsigned int index, unsigned char *buff, unsigned int max_buff_len, unsigned int *bufflen);
    bool getAppURL(unsigned int index, unsigned char *buff, unsigned int max_buff_len, unsigned int *bufflen);
    bool getAppPicName(unsigned int index, unsigned char *buff, unsigned int max_buff_len, unsigned int *bufflen);
    bool getAppDesc(unsigned int index, unsigned char *buff, unsigned int max_buff_len, unsigned int *bufflen);

private:
    
    PacketHandler * _pkt_handler;
};

#endif /* __APPCENTER_H__ */
