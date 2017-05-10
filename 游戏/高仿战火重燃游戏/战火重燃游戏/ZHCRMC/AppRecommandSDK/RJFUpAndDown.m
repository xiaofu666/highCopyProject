//
//  RJFUpAndDown.m
//  Texas-pokes
//
//  Created by ran on 12-10-8.
//
//

#import "RJFUpAndDown.h"
#import "BasisZipAndUnzip.h"
#import "publicDefine.h"






@implementation RJFUpAndDown
@synthesize delegate;

static  RJFUpAndDown *Mysocket[1] = {nil};


static uchar_t * pv_int_to_byte_array(int32_t intData, uchar_t bytearray[])
{
	bytearray[0] = (uchar_t)((intData & 0xFF000000) >> 24 );
	bytearray[1] = (uchar_t)((intData & 0x00FF0000) >> 16 );
	bytearray[2] = (uchar_t)((intData & 0x0000FF00) >> 8  );
	bytearray[3] = (uchar_t) (intData & 0x000000FF);
    
	return bytearray;
}
//﹏ `R  09:23:38
static uchar_t * pv_uint16_to_byte_array(uint16_t intData, uchar_t bytearray[])
{
	bytearray[0] = (uchar_t)((intData & 0xFF00) >> 8);
	bytearray[1] = (uchar_t) (intData & 0x00FF);
    
	return bytearray;
}

static int setupSocket(char *serverIP, int32_t port)
{
    int sockfd = -1;
    if((sockfd = socket(AF_INET, SOCK_STREAM, 0)) == -1)
    {
        perror("socket");
        exit(errno);
    }
    return sockfd;
}
static int connetToHost(int socket_file, char *serverIP, int32_t port)
{
    struct sockaddr_in addr;
	memset(&addr,0,sizeof(struct sockaddr_in));
	
	addr.sin_len = sizeof(struct sockaddr_in);
	addr.sin_family = AF_INET;
	addr.sin_port = htons(port);
    addr.sin_addr.s_addr = inet_addr(serverIP);
    
    /*
     int flags = fcntl(socket_file, F_GETFL,0);
     fcntl(socket_file,F_SETFL, flags | O_NONBLOCK);
     */
    
    //bool ret = false;
    int connect_result = connect(socket_file,(struct sockaddr *)&addr,sizeof(struct sockaddr_in));
    
#ifdef DEBUG_VERSION
    NSLog(@"connect_result:%d", connect_result);
#endif
    
    /*
     fd_set          fdwrite;
     struct timeval  tvSelect;
     
     FD_ZERO(&fdwrite);
     FD_SET(socket_file, &fdwrite);
     tvSelect.tv_sec = 2;
     tvSelect.tv_usec = 0;
     int retval = select(socket_file + 1,NULL, &fdwrite, NULL, &tvSelect);
     if(retval < 0)
     {
     if ( errno == EINTR )
     {
     NSLog(@"select error");
     }
     else
     {
     NSLog(@"error");
     close(socket_file);
     }
     }
     else if(retval == 0)
     {
     NSLog(@"select timeout........");
     }
     else if(retval > 0)
     {
     ret = YES;
     }
     */
    /*
     if (connect_result) {
     flags = fcntl(socket_file, F_GETFL,0);
     flags &= ~ O_NONBLOCK;
     fcntl(socket_file,F_SETFL, flags);
     }
     */
    
    struct sigaction sa;
    sa.sa_handler = SIG_IGN;
    sigaction(SIGPIPE, &sa, 0 );
    
    return connect_result;
}

static void mmc_vim_net_disconnect_file(int socket_file, recvFile *recvData)
{
    close(socket_file);
    // socket_file = -1;
    
    if (recvData->pBuff != NULL) {
        free(recvData->pBuff);
        recvData->pBuff = NULL;
    }
    
}
static void GetDateSmallEndian(void* src, void* dst, int32_t len)
{
	if(!src || !dst)
		return;
	char* pSrc = (char*)src;
	char* pDst = (char*)dst;
	
	int j=len-1;
	for(int i = 0; i < len; i++)
	{
		pDst[j--] = pSrc[i];
	}
}


static void mmc_vim_send_file_data(int socket_file, unsigned char *out_buf, int out_buf_size, int type)
{
    NSLog(@"send size:%d",out_buf_size);
	int send_data_size =  send(socket_file, out_buf, out_buf_size, 0);
    
    if (send_data_size == -1)
    {
        
        NSLog(@"send error:%s %d", strerror(errno), errno);
        NSLog(@"send_data_size in file:%d", send_data_size);
        
        
        /* if (type == enum_upload_file_request) {
         
         }else {
         [[NSNotificationCenter defaultCenter] postNotificationName:@"download_file_failure" object:nil];
         }*/
    }
}

//接收：服务器返回结果
//参数：
//optType:操作类型 1表示上传 2表示下载
static void mmc_vim_net_recvPackage_File(int socket_file, id delegate, NSString *ImageName, uint32_t peerID, int type, int optType)
{
    recvFile recvData = {0};
    
    if (recvData.pBuff == NULL) {
        recvData.pBuff = (char *)malloc(sizeof(char) * 14);
        recvData.total_size = 14;
        recvData.recv_size = 0;
        recvData.be_get_size = 14;
    }
    
    int recvSize = 0;
    while (1)
    {
        recvSize = recv(socket_file, recvData.pBuff+recvData.recv_size, recvData.be_get_size-recvData.recv_size, 0);
        NSLog(@"recvsize:%d",recvSize);
        if (recvSize == -1)
        {
            break;
        }else if (recvSize > 0)
        {
            recvData.recv_size += recvSize;
            if (recvData.recv_size == recvData.be_get_size && recvData.recv_size == 14)
            {
                int32_t totalSize;
                GetDateSmallEndian(&recvData.pBuff[4], &totalSize, 4);
                recvData.total_size = totalSize;
                recvData.be_get_size = totalSize;
                
                char *pData_new = (char*)malloc(sizeof(char) * totalSize);
                memcpy(pData_new, recvData.pBuff, recvData.recv_size);
                free(recvData.pBuff);
                recvData.pBuff = pData_new;
                
            }else if (recvData.recv_size == recvData.be_get_size)
            {
                break;
            }
        }else if (recvSize == 0)
        {
            mmc_vim_net_disconnect_file(socket_file, &recvData);
            /*if (optType == 2) {
             #ifdef DEBUG_VERSION
             NSLog(@"DownloadPicture failth");
             #endif
             [[NSNotificationCenter defaultCenter] postNotificationName:@"download_file_failure" object:nil];
             [[SQLOperation sharedSQLOperation] updateDownloadPictureResult:ImageName Status:2];
             isDownloadImage = NO;
             }else if (optType == 1) {
             [[SQLOperation sharedSQLOperation] updateDownloadPictureResult:ImageName Status:7];
             }
             
             free(recvData.pBuff);
             recvData.pBuff = NULL;
             return;
             }*/
        }
    }
    
    NSLog(@"recv****");
    [delegate phaseFile:[NSData dataWithBytes:recvData.pBuff length:recvData.recv_size]];
    /* if (recvData.recv_size == recvData.be_get_size && recvData.recv_size > 14)
     {
     [delegate phaseFile:[NSData dataWithBytes:recvData.pBuff length:recvData.recv_size]];
     //mmc_vim_handle_recv_data(socket_file, &recvData, recvData.recv_size, cellFlag, ImageName, peerID, type);
     }else
     {
     [delegate phaseFile:[NSData dataWithBytes:recvData.pBuff length:recvData.recv_size]];
     if (optType == 2) {
     #ifdef DEBUG_VERSION
     NSLog(@"DownloadPicture failth");
     #endif
     
     /// isDownloadImage = NO;
     }else if (optType == 1)
     {
     //  [[SQLOperation sharedSQLOperation] updateDownloadPictureResult:ImageName Status:7];
     }
     }*/
    
    free(recvData.pBuff);
    recvData.pBuff = NULL;
}


+(id)shareInitWithHost:(NSString *)Host
                  Port:(u_int)iPort
              Delagate:(id)Mydelegate
                   tag:(NSInteger)itag
{
    
    
    if (Mysocket[itag] == nil)
    {
        Mysocket[itag] = [[RJFUpAndDown alloc] initWithHost:Host
                                                       Port:iPort
                                                   Delagate:Mydelegate
                                                        tag:itag];
    }
    return Mysocket[itag];
}

+(id)shareWithTag:(NSInteger)iTag
{
    return Mysocket[iTag];
}

-(void)readMessage:(id)Thread
{
    
}

-(id)initWithHost:(NSString *)Host
             Port:(uint16_t)iPort
         Delagate:(id)Mydelegate
              tag:(NSInteger)itag
{
    self = [super init];
    if (self)
    {
        
        
        
        self.host = Host;
        self.port = iPort;
        delegate = Mydelegate;
        m_itag = itag;
       
        
    }
    return self;
    
}
-(id)ReConnectToHost:(NSString *)Host port:(uint16_t)port delegate:(id)Delegate tag:(int32_t)iTag
{

    
    self.host = Host;
    self.port = port;
    
    delegate = Delegate;
    m_itag = iTag;
    return self;
}

-(id)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

- (void)readStream
{
    
	
}



-(void)dealloc
{

    [super dealloc];
}

-(id)TcpSocketOftag:(NSInteger)tag
{
    if (self)
    {
        return self;
    }else
    {
        return nil;
    }
}


-(void)uploadfile:(NSString *)fileName filedata:(NSData *)fileData
{
    if ([fileName length] < 20 )
    {
        NSLog(@"upload file not leagal  filename:%@",fileName);
        return;
    }
    

    int socketFile = setupSocket(NULL, 0);
    int ret = 0;
    if (socketFile > 0)
    {
        ret = connetToHost(socketFile, (char *)[self.host UTF8String], self.port);
    }
    
    if (ret != 0)
    {
        mmc_vim_net_recvPackage_File(socketFile, self, fileName, 0, 0, 1);
        return;
    }
    
    int32_t headsize = 14;
    char  *fileNameByte = (char*)[fileName UTF8String];
    BasisZipAndUnzip   *basic = [[BasisZipAndUnzip alloc] initWithSize:[fileData length]+200];
    //int8_t  *upfilename = [basic stringToInt_8:fileName];
    int32_t  fileNameLength = strlen(fileNameByte);//uni_strlen((char *)fileNameByte);
    
    uchar_t  *sendfiledata = (uchar_t *)[fileData bytes];
    int32_t  filedatsize = [fileData length];
    
    
    
    
    int32_t size = headsize+fileNameLength+sizeof(int32_t)*2+filedatsize;
    uint8_t *page = malloc(size);
    uchar_t temp[4] = {0};
    page[0] = 'F';
    page[1] = 'I';
    page[2] = 'L';
    page[3] = 'E';
    pv_int_to_byte_array(size, temp);
    page[4] = temp[0];
    page[5] = temp[1];
    page[6] = temp[2];
    page[7] = temp[3];
    pv_int_to_byte_array(headsize, temp);
    page[8] = temp[0];
    page[9] = temp[1];
    page[10] = temp[2];
    page[11] = temp[3];
    
    pv_uint16_to_byte_array(UPLOADREQUESTID, temp);
    page[12] = temp[0];
    page[13] = temp[1];
    
    pv_int_to_byte_array(fileNameLength, temp);
    page[14] = temp[0];
    page[15] = temp[1];
    page[16] = temp[2];
    page[17] = temp[3];
    memcpy(page+headsize+4, fileNameByte, fileNameLength);
    pv_int_to_byte_array(filedatsize, temp);
    
    page[headsize+4+fileNameLength] = temp[0];
    page[headsize+4+fileNameLength+1] = temp[1];
    page[headsize+4+fileNameLength+2] = temp[2];
    page[headsize+4+fileNameLength+3] = temp[3];
    memcpy(page+(headsize+4*2+fileNameLength), sendfiledata,filedatsize);
    //   [self SendCharMessage:page size:size];
    mmc_vim_send_file_data(socketFile, page, size, 0);
    mmc_vim_net_recvPackage_File(socketFile, self, fileName, 1, 1, 1);
    
    [basic release];
    free(page);
    page = NULL;    
}

+(UIImage *)getLocalImage:(NSString *)strFileName
{
//    if ([strFileName rangeOfString:@"."].location == NSNotFound)
//    {
//        strFileName = [strFileName stringByAppendingString:@".jpg"];
//    }
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    strFileName = [documentsDirectory stringByAppendingPathComponent:strFileName];
    
    
    NSFileManager  *fileMange = [NSFileManager defaultManager];
    if ([fileMange fileExistsAtPath:strFileName])
    {
        UIImage  *image = [[[UIImage alloc] initWithContentsOfFile:strFileName] autorelease];
        NSLog(@"headPic %@ is exist in dir",strFileName);
        return image;
    }else
    {
        return nil;
    }
}


-(void)phaseFile:(NSData *)data
{
    BasisZipAndUnzip  *objZip = [[BasisZipAndUnzip alloc] initWithSize:[data length]+5];
    [objZip setPos:0];
    [objZip pushData:(int8_t *)[data bytes] size:[data length]];
    [objZip setPos:0];
    int8_t  checkCode = [objZip getInt8];
    if (checkCode != 'F')
    {
        [objZip release];
        return;
    }
    checkCode = [objZip getInt8];
    if (checkCode != 'I')
    {
        [objZip release];
        return;
    }
    checkCode = [objZip getInt8];
    if (checkCode != 'L')
    {
        [objZip release];
        return;
    }
    checkCode = [objZip getInt8];
    if (checkCode != 'E')
    {
        [objZip release];
        return;
    }
    
    int16_t  requestID = [objZip unbyte_to_int16:[objZip getData] pos:12];
    if (requestID == UPLOADREQUESTID)
    {
        [objZip setPos:14];
        if (delegate && [delegate respondsToSelector:@selector(UploadSucOrFail:)])
        {
            [delegate UploadSucOrFail:[objZip getInt8]];
        }
        
    }else if (requestID == DOWNLOADREQUESDID || requestID == DOWNAPPPICID)
    {
        [objZip setPos:14];
        int8_t  status = [objZip getInt8];
        //    NSLog(@"downstatus:%d",status);
        if (status)
        {
            NSAutoreleasePool  *pool = [[NSAutoreleasePool alloc] init];
            int32_t fileLength = [objZip getInt32];
            [objZip getStringAccordSize:fileLength];
            
            char *charString = malloc(fileLength);
            memset(charString, '\0', fileLength);
            memcpy(charString, [data bytes]+14+5, fileLength);
            NSString  *strFileName = [NSString stringWithCString:charString encoding:NSUTF8StringEncoding];
            free(charString);
            //  fileName = [NSString stringWithCString:[fileName UTF8String] encoding:NSASCIIStringEncoding];
            int32_t  fileSize = [objZip getInt32];
            
            int8_t  *fileContent = malloc(fileSize);
            if (fileContent != NULL)
            {
                fileContent = memcpy(fileContent, [objZip getData]+[objZip dataSize], fileSize);
            }
            
            NSData  *filedata = [NSData dataWithBytes:fileContent length:fileSize];
            UIImage *image = [UIImage imageWithData:filedata];
            [self WriteToLocal:[NSDictionary dictionaryWithObjectsAndKeys:filedata,@"DATA",strFileName,@"FILENAME", nil]];
            if (delegate && [delegate respondsToSelector:@selector(DownLoadSuOrFail:ISSuc:)])
            {
                [delegate DownLoadSuOrFail:image ISSuc:YES];
            }
            
           
            
            //[self performSelector:@selector(WriteToLocal:) withObject:[NSDictionary dictionaryWithObjectsAndKeys:filedata,@"DATA",strFileName,@"FILENAME", nil]];
            free(fileContent);
            [pool drain];
            //NSLog(@"fileName:%@,filedata:%@ file size:%d",fileName,filedata,fileSize);
            
        }else
        {
            NSLog(@"downFile fail");
            [delegate DownLoadSuOrFail:nil ISSuc:NO];
        }
        
        
    }
    [objZip release];
    objZip = nil;
}

//  DATA-------NSDATA
//  FILENAME ------   FILENAME

-(void)WriteToLocal:(NSDictionary *)dicInfo
{
  //  NSAutoreleasePool  *pool = [[NSAutoreleasePool alloc] init];
    NSData  *data = [dicInfo valueForKey:@"DATA"];
    NSString  *strFileName = [dicInfo valueForKey:@"FILENAME"];
//    if ([strFileName rangeOfString:@"."].location == NSNotFound)
//    {
//        strFileName = [strFileName stringByAppendingString:@".jpg"];
//    }
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    strFileName = [documentsDirectory stringByAppendingPathComponent:strFileName];

    
    
    NSFileManager  *fileMange = [NSFileManager defaultManager];
    NSError  *error = nil;
    if ([fileMange fileExistsAtPath:strFileName])
    {
        [fileMange removeItemAtPath:strFileName error:&error];
    }
    
    if (![fileMange createFileAtPath:strFileName contents:nil attributes:nil])
    {
        NSLog(@"creat file fail");
    }
    
    if ([data writeToFile:strFileName atomically:YES])
    {
        NSLog(@"write to file suc");
    }else
    {
        NSLog(@"write to file fail!");
    }
  //  [pool drain];
    
}


-(UIImage *)SendDownRequest:(NSString *)fileName requestID:(NSInteger)request
{
    //NSLog(@"down file request file name:%@",fileName);
    if ([fileName length] < 20)
    {
        NSLog(@"filename lenth unleagal  fileName:%@",fileName);
        return nil;
    }
    UIImage  *image = [RJFUpAndDown getLocalImage:fileName];
    if (image != nil)
    {
        return image;
    }
    
    
    int socketFile = setupSocket(NULL, 0);
    int ret = 0;
    if (socketFile > 0)
    {
        ret = connetToHost(socketFile, (char *)[self.host UTF8String], self.port);
    }
    
    if (ret != 0)
    {
        mmc_vim_net_recvPackage_File(socketFile, self, fileName, 0, 0, 2);
        return nil;
    }

    
    int32_t headsize = 14;
    BasisZipAndUnzip   *basic = [[BasisZipAndUnzip alloc] initWithSize:200];
    char  *upfilename =  (char*)[fileName UTF8String];
    int32_t  fileNameLength = strlen(upfilename);//uni_strlen((char *)upfilename);
    int32_t size = headsize+fileNameLength+sizeof(int32_t);
    uint8_t *page = malloc(size);
    uchar_t temp[4] = {0};
    page[0] = 'F';
    page[1] = 'I';
    page[2] = 'L';
    page[3] = 'E';
    pv_int_to_byte_array(size, temp);
    page[4] = temp[0];
    page[5] = temp[1];
    page[6] = temp[2];
    page[7] = temp[3];
    pv_int_to_byte_array(headsize, temp);
    page[8] = temp[0];
    page[9] = temp[1];
    page[10] = temp[2];
    page[11] = temp[3];
    
    pv_uint16_to_byte_array(request, temp);
    page[12] = temp[0];
    page[13] = temp[1];
    
    pv_int_to_byte_array(fileNameLength, temp);
    page[14] = temp[0];
    page[15] = temp[1];
    page[16] = temp[2];
    page[17] = temp[3];
    memcpy(page+headsize+4, upfilename, fileNameLength);
    
    mmc_vim_send_file_data(socketFile, page, size, 0);
    mmc_vim_net_recvPackage_File(socketFile, self, fileName, 1, 1, 2);
    [basic release];
    basic = nil;
    free(page);
    page = NULL;
    
    return image;
    
}




@end
