#ifndef __PUSHCLIENT_INC_PACKETHANDLER_H__
#define __PUSHCLIENT_INC_PACKETHANDLER_H__

#include <string>
#include <vector>
#include "sdstatus.h"
#include "easypacket.h"
#include "mychallenge.h"
#include "myrandom.h"
#include "mychallengekey.h"
#include "mykeymanager.h"
#include "myencryptor.h"
#include "applicationdef.h"
#include "clientplatform.h"
#include "applicationdef.h"
#include "companydef.h"
#include "languagedef.h"

using namespace std;

#define APPCENTERCLIENT_PROTOCOL_ID           20121017
#define TRANSLAYER_PROTOCOL_ID                20120710

struct AppCenterAppInfo
{
    AppCenterAppInfo():
        app_id(0),
        app_update_time(0),
        app_size(0),
        app_sequence(0),
        app_ver(),
        app_language(eILT_Chinese),
        app_name(),
        app_url(),
        app_picname(),
        app_desc(),
        apk_name(),
        apk_ver_num(0)
    {
    }

    unsigned int      app_id;
    unsigned int      app_update_time;
    unsigned int      app_size;
    unsigned int      app_sequence;
    string            app_ver;
    eI366LanguageType app_language;

    string            app_name;
    string            app_url;
    string            app_picname;
    string            app_desc;

    // for android
    string            apk_name;
    unsigned int      apk_ver_num;
};

class PacketHandler
{
public:

    typedef enum
    {        
        ePT_RA_Hello                      = 1000,
        ePT_RA_Question                   = 1001,
        ePT_RA_Authorized                 = 1002,
        ePT_RA_AppUpdateTime              = 1003,
        ePT_RA_AppInfo                    = 1004,
        ePT_RA_DownloadAppSuccess         = 1005,

        // Add before this line.
        ePT_Ends
    }ePacketType;
    

    typedef enum
    {
        PACKET_HEADER_LEN                    =  32,
        MAX_PACKET_BUFF_LEN                  =  20480, /* 20 KB */
        MAX_TMP_BUFFER_SIZE                  =  10240,

        // Add before this line.
        ePHContant_Ends
    }ePHContants;

public:
    PacketHandler(unsigned int user_id, unsigned int app_id, unsigned int language);
    ~PacketHandler();

private:
    PacketHandler(const PacketHandler &);

public:

    bool init();

    bool analyzeHandshakePkt(const unsigned char *buff, unsigned int bufflen);
    bool createHandshakePkt(unsigned char *buff, unsigned int max_buff_len, unsigned int &bufflen);

    bool analyzeQuestionPkt(const unsigned char *buff, unsigned int bufflen);
    bool createQuestionAnswerPkt(unsigned char *buff, unsigned int max_buff_len, unsigned int &bufflen);

    bool analyzeAuthorizedPkt(const unsigned char *buff, unsigned int bufflen);

    bool createReqAppCenterUpdateTime(unsigned char *buff, unsigned int max_buff_len, unsigned int &bufflen);
    bool analyzeAppCenterUpdateTime(const unsigned char *buff, unsigned int bufflen);
    bool createReqAppInfo(unsigned char *buff, unsigned int max_buff_len, unsigned int &bufflen);
    bool analyzeAppInfo(const unsigned char *buff, unsigned int bufflen);
    bool createReportDownloadSuccess(unsigned char *buff, unsigned int max_buff_len, unsigned int &bufflen, unsigned int downloaded_app);
    bool analyzeReportDownloadSuccessAck(const unsigned char *buff, unsigned int bufflen);

    bool getFileServerPort(unsigned int &port);
    bool getFileServerIP(string &ip);

    bool getAppCenterUpdateTime(unsigned int *updatetime);

    bool getAppTotalApp(unsigned int *totalapp);
    bool getAppReceivedApp(unsigned int *received_app);

    bool getAppId(unsigned int index, unsigned int *appid);
    bool getAppUpdateTime(unsigned int index, unsigned int *updatetime);
    bool getAppSize(unsigned int index, unsigned int *appsize);
    bool getAppDisplaySequence(unsigned int index, unsigned int *seq);
    bool getAppApkVerNum(unsigned int index, unsigned int *apk_ver);
    bool getAppLanguage(unsigned int index, unsigned int *language);
    bool getAppVersionStr(unsigned int index, unsigned char *buff, unsigned int max_buff_len, unsigned int &bufflen);
    bool getAppName(unsigned int index, unsigned char *buff, unsigned int max_buff_len, unsigned int &bufflen);
    bool getAppURL(unsigned int index, unsigned char *buff, unsigned int max_buff_len, unsigned int &bufflen);
    bool getAppPicName(unsigned int index, unsigned char *buff, unsigned int max_buff_len, unsigned int &bufflen);
    bool getAppDesc(unsigned int index, unsigned char *buff, unsigned int max_buff_len, unsigned int &bufflen);
    bool getApkName(unsigned int index, unsigned char *buff, unsigned int max_buff_len, unsigned int &bufflen);

private:
    void createHeader(unsigned int datalen);
    bool checkHeader();
    bool packet2Buffer(unsigned char *buff, unsigned int max_buff_len, unsigned int &bufflen);
    bool getPacket(const unsigned char *buff, unsigned int bufflen);

private:

    unsigned char *             _pkt_buffer;
    unsigned int                _pkt_buffer_len;
        
    EasyPacket *                _easy_pkt;
    unsigned int                _packet_data_size;

    MyChallenge *               _challenge;

    
    unsigned int                _local_key_id;
    unsigned int                _remote_key_id;

    MyEncryptor*                _recv_decryptor;
    MyEncryptor*                _send_encryptor;

    string                      _file_server_ip;
    unsigned int                _file_server_port;

    unsigned int                _app_id;
    eClientPlatform             _platform_id;
    eCompanyEnum                _company_id;
    eI366LanguageType           _language;
    unsigned int                _user_id;

    ePacketType                 _packet_type;

    unsigned int                _last_update_time;
    unsigned int                _total_app_num;
    unsigned int                _recvd_app_num;
    vector<AppCenterAppInfo*>   _app_info_list;

    unsigned char *             _buffer;
};

#endif /* __PUSHCLIENT_INC_PACKETHANDLER_H__ */
