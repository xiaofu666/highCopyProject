//
//  RJFUpAndDown.h
//  Texas-pokes
//
//  Created by ran on 12-10-8.
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

typedef  int8_t uchar_t;
typedef struct recvFile
{
    char *pBuff;
    int32_t total_size;
    int32_t recv_size;
    int32_t be_get_size;           //想要获取的长度
    
}recvFile;

@protocol BNRUpAndDownLoadFile <NSObject>

@optional
-(void)UploadSucOrFail:(BOOL)bSuc;
-(void)DownLoadSuOrFail:(UIImage *)image ISSuc:(BOOL)bSUc;
@end

@interface RJFUpAndDown : NSObject
{
    id                  delegate;
    NSInteger           m_itag;
    NSString            *m_Host;
    UInt16              m_port;
}
//@property(nonatomic,assign)id<BNRSOCKRECMESGFROMSERVER>  delegate;
@property(assign)   id    delegate;
@property(readwrite) NSInteger tag;
//@property(retain)   AsyncSocket *socket;
@property(copy)     NSString *host;
@property(readwrite) UInt16 port;


//-(id)initWithHost:(NSString *)Host Port:(u_int)iPort  Delagate:(id)Mydelegate;
//-(void)SendMessage:(NSString *)strMessage;
-(id)TcpSocketOftag:(NSInteger)tag;
-(id)initWithHost:(NSString *)Host
             Port:(uint16_t)iPort
         Delagate:(id)Mydelegate
              tag:(NSInteger)itag;
+(id)shareWithTag:(NSInteger)iTag;
+(id)shareInitWithHost:(NSString *)Host
                  Port:(u_int)iPort
              Delagate:(id)Mydelegate
                   tag:(NSInteger)itag;
-(id)ReConnectToHost:(NSString *)Host port:(u_int16_t)port delegate:(id)Delegate tag:(int32_t)iTag;

-(void)phaseFile:(NSData *)data;
-(void)uploadfile:(NSString *)fileName filedata:(NSData *)fileData;
+(UIImage *)getLocalImage:(NSString *)strFileName;
-(UIImage *)SendDownRequest:(NSString *)fileName requestID:(NSInteger)request;
@end
