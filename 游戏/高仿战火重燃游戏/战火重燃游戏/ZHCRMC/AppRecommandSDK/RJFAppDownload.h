//
//  RJFTcpSocket.h
//  Texas-pokes
//
//  Created by ran on 12-8-14.
//
//

#import <Foundation/Foundation.h>
#import <CoreFoundation/CoreFoundation.h>
#import <Foundation/Foundation.h>
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>
#import <unistd.h>
#import "AsyncSocket.h"


//#include "appcenter.h"


#ifndef MAXAPPINFO
#define MAXAPPINFO      1024*20
#endif

@protocol BNRDOWNAPPINFO <NSObject>
@optional
-(void)DisConnectError;
-(void)receiveAppInfo:(NSDictionary *)dicInfo;
@end



@interface RJFAppDownload : NSObject
{
    AsyncSocket         *m_socket;
    id<BNRDOWNAPPINFO>                  delegate;
    NSInteger           m_itag;
    BOOL                m_bconnectSuc;
    BOOL                m_haveSendTheDictInfo;
    NSString            *m_Host;
    UInt16              m_port;
    NSMutableData       *receiveData;
    NSMutableArray      *m_storeData;
    NSLock              *m_lock;

    int                 m_iRecDataCount;
    unsigned char       m_data[MAXAPPINFO];
    
    NSTimeInterval        m_timeSince1970;
    
   // AppCenter           *app_info;
}
@property(nonatomic,assign)id<BNRDOWNAPPINFO>  delegate;
@property(readwrite) NSInteger tag;
@property(readwrite) BOOL      connectSuc;
@property(retain)   AsyncSocket *socket;
@property(copy)     NSString *host;
@property(readwrite) UInt16 port;
//@property(copy)NSMutableData  *receiveData;

-(void)disConnect;
-(void)SendCharMessage:(unsigned char *)data size:(size_t)size;
-(id)TcpSocketOftag:(NSInteger)tag;
-(id)initWithHost:(NSString *)Host
             Port:(uint16_t)iPort
         Delagate:(id)Mydelegate
            AppID:(NSInteger)AppID;

@end
