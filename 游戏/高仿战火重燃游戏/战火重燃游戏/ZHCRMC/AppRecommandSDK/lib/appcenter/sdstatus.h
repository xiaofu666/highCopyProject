#ifndef __COMMON_INC_SDSTATUS_H__
#define __COMMON_INC_SDSTATUS_H__

// Standard status.
typedef enum
{
    eSDS_Unknown                                       = 0,

    eSDS_Init                                          = 1,
    eSDS_Idle                                          = 10,

    eSDS_NeedSend                                      = 100,
    eSDS_Sending                                       = 101,
    eSDS_Sent                                          = 102,

    eSDS_NeedRecv                                      = 110,    
    eSDS_Recving                                       = 111,
    eSDS_Recvd                                         = 112,

    eSDS_Processing                                    = 150,
    
    eSDS_NeedWait                                      = 160,
    
    eSDS_Complete                                      = 1000,
    eSDS_Downloaded                                    = 1001,
    eSDS_Uploaded                                      = 1002,

    
    eSDS_Ok                                            = 19999,
    
    // Below statuses are errors.
    eSDS_Error                                         = 20000,
    eSDS_OutOfMemoryError                              = 20001,
    eSDS_RemoteDisconnectedError                       = 20002,
    eSDS_TimeoutError                                  = 20003,
    eSDS_TransLayerPacketHeaderError                   = 20004,
    eSDS_InternalLogicalError                          = 20005,
    eSDS_PacketTooBigError                             = 20006,
    eSDS_AppLogicalError                               = 20007,
    eSDS_FileNotFoundError                             = 20008,
    eSDS_AppProtocolError                              = 20009,
    eSDS_BufferSizeError                               = 20010,
    eSDS_FileNameLenError                              = 20011,
    eSDS_TransLayerSendError                           = 20012,
    eSDS_TransLayerRecvError                           = 20013,
    eSDS_NetworkError                                  = 20014,
    eSDS_PacketError                                   = 20015,
    eSDS_ChallengeError                                = 20016,
    eSDS_UserAlreadyExistError                         = 20017,
    eSDS_UserRegiserError                              = 20018,
    eSDS_ForceDisconnectError                          = 20019,
    
    //Fatal error. Cannot be recovered.
    eSDS_FatalError                                    = 40000,
    eSDS_FileSystemError                               = 40001
}eSDStatus;

#endif
