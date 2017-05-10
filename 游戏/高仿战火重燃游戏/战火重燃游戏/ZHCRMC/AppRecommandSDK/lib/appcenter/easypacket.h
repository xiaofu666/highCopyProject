#ifndef __EASYNET_INC_EASYPACKET_H__
#define __EASYNET_INC_EASYPACKET_H__

#include <assert.h>
#include <iostream>

using namespace std;


class DataNode;

class EasyPacket
{
  public:
    typedef enum
    {
        // Common Datatype
        eEPDT_Unknown                                          = 0,
        eEPDT_PacketType                                       = 1,
        eEPDT_StringLen                                        = 2,
        eEPDT_String                                           = 3,
        eEPDT_Uint32                                           = 4,
        eEPDT_SDStatus                                         = 5,
        eEPDT_ProtocolId                                       = 6,
        eEPDT_ClientNum                                        = 7,
        eEPDT_AppId                                            = 8,
        eEPDT_PlatformId                                       = 9,
        eEPDT_UserId                                           = 10,
        eEPDT_CompanyId                                        = 11,
        eEPDT_PassWD                                           = 12,
        eEPDT_IPV4Addr                                         = 13,
        eEPDT_Port                                             = 14,
        eEPDT_Latitude                                         = 15,
        eEPDT_Longitude                                        = 16,
        eEPDT_MessageId                                        = 17,
        eEPDT_MessageLen                                       = 18,
        eEPDT_PushType                                         = 19,
        eEPDT_MatchType                                        = 20,
        eEPDT_TextMessage                                      = 21,
        eEPDT_StartTime                                        = 22,
        eEPDT_EndTime                                          = 23,
        eEDPT_CityName                                         = 24,
        eEDPT_GeoHashString                                    = 25,
        eEDPT_NeedSendMsgFlag                                  = 26,
        eEDPT_MessageNum                                       = 27,
        eEDPT_LoginTime                                        = 28,
        eEDPT_Language                                         = 29,
        eEDPT_Time                                             = 30,
        eEDPT_ListSize                                         = 31,
        eEDPT_URL                                              = 32,
        eEDPT_ClientAppId                                      = 33,
        
        // File data types.
        eEPDT_FileSize                                         = 100,
        eEPDT_FileStream                                       = 101,
        eEPDT_FileStreamSize                                   = 102,
        eEPDT_FileName                                         = 103,
        eEPDT_FileReqType                                      = 104,
        eEPDT_FileType                                         = 105,
        eEDPT_FileExistFlag                                    = 106,

        eEPDT_ChallengeData                                    = 150,
        eEPDT_ChallengeLen                                     = 151,
        eEPDT_SignData                                         = 152,
        eEPDT_SignLen                                          = 153,

        // Monitor service types.
        eEPDT_HostName                                         = 200,
        eEPDT_ServiceDataType                                  = 201,
        eEPDT_ServiceNum                                       = 202,
        eEPDT_ReqServiceTypeItem                               = 203,
        
        eEPDT_MonitorCPUUsage                                  = 220,
        eEPDT_MonitorMemTotal                                  = 221,
        eEPDT_MonitorMemFree                                   = 222,
        eEPDT_MonitorDiskTotal                                 = 223,
        eEPDT_MonitorDiskUsed                                  = 224,
        eEPDT_MonitorDiskFree                                  = 225,
        eEPDT_MonitorDateTime                                  = 226,
        eEPDT_MonitorUploadDataSize                            = 227,
        eEPDT_MonitorDownloadDataSize                          = 228,
        eEPDT_MonitorOnlineUserNum                             = 229,
        eEPDT_MonitorUserReqNum                                = 230,
        eEPDT_MonitorDBBusyConnNum                             = 231,

        eEPDT_AppTotal                                         = 300,
        eEPDT_AppSequence                                      = 301,
        eEPDT_AppName                                          = 302,
        eEPDT_AppPicName                                       = 303,
        eEPDT_AppDesc                                          = 304,
        eEPDT_AppVersion                                       = 305,
        eEPDT_AppSize                                          = 306,
        eEPDT_ApkName                                          = 307,
        eEPDT_ApkVersionNum                                    = 308,
        
        
        // Add normal data above this line.
        eEPDT_NormalDataTypeEnd                                = 0x7FFFFF,



        //////////////////////////////////////
        // Attention, the following types are list:  //
        /////////////////////////////////////
        
        eEPDT_ListStartIdx                                     = 0x800000,
        eEPDT_FileNameList                                     = 0x800001,
        eEPDT_MessageIdList                                    = 0x800002,
        eEPDT_ServiceTypeList                                  = 0x800003,
        eEPDT_ServiceMonitorList                               = 0x800004,
        eEPDT_AppInfoList                                      = 0x800005,

        // Add list object above this line.
        eEPDT_ListTypeEnd                                      = 0x9FFFFF
    }eDataType;

  public:
    EasyPacket();
    ~EasyPacket();

  private:
    EasyPacket(const EasyPacket &);

  private:
    int storeDataType(eDataType type, 
                      unsigned char **buff,
                      unsigned int bufflen,
                      unsigned int &usedlen);

    int storeDataLen(unsigned int datalen, 
                     unsigned char **buff,
                     unsigned int bufflen,
                     unsigned int &usedlen);

    int storeData(const unsigned char * data,
                  unsigned int datalen,
                  unsigned char **buff,
                  unsigned int bufflen,
                  unsigned int &usedlen);

  public:

    int buff2Packet(DataNode **front, const unsigned char * buff, unsigned int bufflen);
    int packet2Buff(DataNode *head, DataNode *tail, unsigned char *buff, unsigned int bufflen, unsigned int &usedlen);

    int addUint32(eDataType type, unsigned int data);
    int getUint32(eDataType type, unsigned int &data);

    int addString(eDataType type, const unsigned char * data, unsigned int len);
    int getString(eDataType type, unsigned char * data, unsigned int maxlen, unsigned int &readlen);

    // Array objects.
    DataNode * addListObj(eDataType type);
    DataNode * addSubUint32(DataNode* node, eDataType type, unsigned int data);
    DataNode * addSubString(DataNode* node, eDataType type, const unsigned char * data, unsigned int len);

    DataNode* getNode(eDataType type);
    DataNode* headNode() {return _head;}
    DataNode* tailNode() {return _tail;}

  private:
    DataNode* _head;
    DataNode* _tail;
    DataNode* _last_insert_node;
};


class DataNode
{
  public:

    typedef enum 
    {
        eDNT_Unknown,
        eDNT_Head,
        eDNT_Tail,
        eDNT_Data,
        eDNT_List
    }eDNType;

  public:

    DataNode();
    DataNode(EasyPacket::eDataType data_type);
    virtual ~DataNode();

  public:

    static DataNode * findNode(DataNode *head, DataNode *tail, EasyPacket::eDataType type);
    static DataNode * findSubNodeByIdx(DataNode *head, DataNode * tail, EasyPacket::eDataType type, unsigned int idx);

  public:
    void pushBackNode(DataNode *node);

  public:
    virtual eDNType nodeType() = 0;
    virtual EasyPacket::eDataType dataType() { return _data_type; }
    virtual unsigned char* data() const { assert(0); return NULL; }
    virtual unsigned int size() const { assert(0); return 0; }
    virtual DataNode * next() { return _next; }
    virtual void setNext(DataNode *n) { _next = n; }


    // Keep complier slience.
    virtual DataNode * headSubNode() { assert(0); return 0; }
    virtual DataNode * tailSubNode() { assert(0); return 0; }
    
    // The following 4 API is for list obj.
    virtual int findUint32(EasyPacket::eDataType type, unsigned int &value);
    virtual int findString(EasyPacket::eDataType type, unsigned int max_len, unsigned char *result, unsigned int &result_len);
    virtual int findUint32ByIdx(EasyPacket::eDataType type, unsigned int idx, unsigned int &value);
    virtual int findStringByIdx(EasyPacket::eDataType type, unsigned int idx, unsigned int max_len, unsigned char *result, unsigned int &result_len);

  protected:
    DataNode *_next;
    EasyPacket::eDataType _data_type;
};

class HeadDataNode : public DataNode
{
  public:
    HeadDataNode();
    ~HeadDataNode();

  private:
    HeadDataNode(const HeadDataNode &);

  public:
    virtual eDNType nodeType() { return eDNT_Head; }
};

class TailDataNode : public DataNode
{
  public:
    TailDataNode();
    ~TailDataNode();

  private:
    TailDataNode(const TailDataNode&);

  public:
    virtual eDNType nodeType() { return eDNT_Tail; }
    virtual void setNext(DataNode *n) { assert(n==NULL); _next = n; } 
    
};

class NormalDataNode : public DataNode
{
  public:
    NormalDataNode(EasyPacket::eDataType datatype, const unsigned char * data, unsigned int datalen);
    ~NormalDataNode();

  private:
    NormalDataNode(const NormalDataNode &);

  public:
    virtual eDNType nodeType() { return eDNT_Data; }
    virtual unsigned char* data() const { return _data; }
    virtual unsigned int size() const { return _data_size; }

  private:
    unsigned char * _data;
    unsigned int _data_size;
};

class ListObjDataNode : public DataNode
{
  public:
    ListObjDataNode(EasyPacket::eDataType);
    ~ListObjDataNode();

  private:
    ListObjDataNode(const ListObjDataNode &);

  public:
    virtual eDNType nodeType() { return eDNT_List; }

    virtual int findUint32(EasyPacket::eDataType type, unsigned int &value);
    virtual int findString(EasyPacket::eDataType type, unsigned int max_len, unsigned char *result, unsigned int &result_len);

    virtual int findUint32ByIdx(EasyPacket::eDataType type, unsigned int idx, unsigned int &value);
    virtual int findStringByIdx(EasyPacket::eDataType type, unsigned int idx, unsigned int max_len, unsigned char *result, unsigned int &result_len);

    virtual DataNode * headSubNode() { return _sub_head; }
    virtual DataNode * tailSubNode() { return _sub_tail; }

  private:
    DataNode * _sub_head;
    DataNode * _sub_tail;
};

#endif
