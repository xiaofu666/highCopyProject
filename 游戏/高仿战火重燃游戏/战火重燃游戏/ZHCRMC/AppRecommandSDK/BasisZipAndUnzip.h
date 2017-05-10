//
//  BasisZipAndUnzip.h
//  zipandUnzip
//
//  Created by ran on 12-8-15.
//  Copyright (c) 2012年 ran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "structandenumForProtrol.h"


int uni_strlen(char *data);
@interface BasisZipAndUnzip : NSObject
{
    size_t _size;
    size_t _data_size;
    int8_t *_data;
    
    DZPK_PRO_UPDOAD_HEADER  m_pro_Header;
    DZPK_PRO_DOWNLOAD_HEADER  m_pro_down_Header;
    
    size_t m_realSize;
    size_t   m_maxsize;
    NSLock   *m_lock;
}

-(id)initWithSize:(size_t)MaxSize;
+(id)shareInstance;
+(id)shareInstanceUnzip;
-(void)HearStructInit:(id)Info;
-(DZPK_PRO_UPDOAD_HEADER)GetHeadStruct;
-(void)setUserID:(int32_t)userID;
-(void)setCustomID:(int16_t)CustomID;
-(void)setProductID:(int16_t)productID;
-(void)setRequestCode:(int16_t)requestCode;
-(void)setPakeageSize:(int16_t)packageSize;
-(void)setHeadSize:(int16_t)headSize;
-(int32_t)userID;
-(int16_t)CustomID;
-(int16_t)ProductID;
-(int16_t)requestCode;
-(int16_t)packageSiZe;
-(int16_t)headSize;
-(BOOL)GetHeadInData:(id)Thread;
-(void)PushHeaderStructData:(id)Thread;
-(void)setItemNumberCountForUpdoad:(int8_t)number;
-(void)i366PushHeadStruct:(size_t)size
                  request:(int16_t)requestCode;
-(NSInteger)isI366ProtolOrDZPKprotol;
-(I366_CLIENT_RECEIVED_PCHC_HEADER)i366GetHeadFromDownServer;





-(int8_t*)getData;
-(bool)pushByte:(int8_t) value;
-(bool) pushInt16:(int16_t) value;
-(bool) pushInt32:(int32_t) value;
//-(bool) pushData:(int8_t *)data size:(int32_t) nsize;
-(bool) pushData:(int8_t *)data size:(size_t) nsize;
-(bool)setByte:(int32_t) offset valueInt8:(int8_t) value;
-(bool) setInt16:(int32_t) offset valueInt16:(int16_t) value;
-(bool) setInt32:(int32_t) offset valueInt32: (int32_t) value;
-(bool) setData:(int32_t)pos data:(int8_t*) data Size:(size_t)nsize;

-(bool) setPos:(size_t) pos;
-(size_t) size;
-(size_t) dataSize;
-(void) clear;
-(int8_t)getInt8Accordpos:(size_t)pos;
//-(int8_t)getInt8Accordpos:(size_t)pos;
-(int16_t)getInt16Accordpos:(size_t)pos;

-(int16_t) unbyte_to_int16:(int8_t * )data pos:(size_t)pos;
-(int32_t) unbyte_to_int32:(int8_t * )data  pos:(size_t)pos;
-(NSString *)getStringAccordPos:(int32_t)pos Size:(size_t) nSize;
-(NSString *)getStringAccordPos:(int32_t)pos Size:(size_t) nSize outdata:(int8_t *)PoutData;


-(int8_t *) stringToInt_8:(NSString *)strTemp;
-(NSString *)getStringAccordSize:(size_t) nSize  pos:(size_t)pos outdata:(int8_t *)PoutData;
-(NSString *)getStringAccordSize:(size_t) nSize;
-(int32_t) getInt32;
-(int16_t)getInt16;
-(int8_t)getInt8;
-(int8_t)getuint8;
-(uint8_t)getItemID;
-(uint8_t)getItemIDAccordPos:(size_t)pos;

//
-(DZPK_PRO_DOWNLOAD_HEADER)GetDownLoadHeader;
-(size_t)GetPackageSizeFromDownHear;
-(int16_t)GetRequestCodeFromDownHear;
-(int8_t)GetPackageLevelFromDownHear;
//-(BOOL)SetDownHeadWithHead;
-(int8_t)getItemNumberForDownLoad;
-(size_t)GetHeadSizeFromDownLoadHead;
-(BOOL)getHeadFromDownloadData:(id)Thread;



@end
