//
//  HHSoftNetWorkEngine.h
//  HHSoftFrameWorkKit
//
//  Created by dgl on 15-3-26.
//  Copyright (c) 2015年 hhsoft. All rights reserved.
//

#import "HHSoftAFNetworking.h"

typedef void(^HHSoftWebResponseSuccessedBlock)(NSString *responseString);
typedef void(^HHSoftWebDownloadFileSuccessBlock)(NSURLResponse *response,NSURL *filePath);
typedef void(^HHSoftWebResponseFailBlock)(NSError *responseError);

typedef enum {
    HttpPost=0,
    HttpGet=1,
    HttpPUT=2
} HTTPMethod;

typedef enum : NSUInteger {
    ParaJson=0,
    ParaBase64=1,
    ParaNormal=2,
} ParaMethod;

typedef enum : NSUInteger {
    ReturnJson=0,
    ReturnBase64=1,
    ReturnNormal=2,
} ReturnValueMethod;

typedef enum :NSUInteger{
    TagSingleImageSingleKey,
    TagMutilImageCycleKey
}UpLoadTag;

@interface HHSoftNetWorkEngine:HHSoftAFHTTPSessionManager


+(id)sharedHHNetWorkEngine;

/**
 *  网络请求数据
 *
 *  @param interfaceUrlPath  接口地址
 *  @param parasDict         参数字典
 *  @param requestmethod     请求方式
 *  @param ParaMethod        参数加密方式（Json就是para-jsonstring，base64是 para-base64string,常规的是多参数-参数值base64的方式）
 *  @param ReturnValueMethod 返回值的加密方式（Json就是公司用的，Base64是一个Base64的字符串）
 *  @param responseSuccessed 请求成功后返回值处理
 *  @param responseFail      请求失败后返回值处理
 *
 *  @return
 */
-(NSURLSessionDataTask *)requestWithUrlPath:(NSString *)interfaceUrlPath
                                parmarDic:(NSMutableDictionary *)parasDict
                                   method:(HTTPMethod)requestmethod
                               paraMethod:(ParaMethod)paraMethod
                        returnValueMethod:(ReturnValueMethod)returnValueMethod
                      onCompletionHandler:(HHSoftWebResponseSuccessedBlock)responseSuccessed onFailHandler:(HHSoftWebResponseFailBlock)responseFail;
/**
 *  上传文件（以文件地址的形式上传）
 *
 *  @param interfaceUrlPath  接口地址
 *  @param filePath          文件地址
 *  @param parasDict         参数字典
 *  @param requestmethod     请求方式
 *  @param fileKeyName       文件的key值
 *  @param responseSuccessed 请求成功后返回值处理
 *  @param responseFail      请求失败后返回值处理
 *
 *  @return
 */
-(NSURLSessionDataTask *)uploadFileWithPath:(NSString *)interfaceUrlPath
                                 filePath:(NSString *)filePath
                                parmarDic:(NSMutableDictionary *)parasDict
                                   method:(HTTPMethod)requestmethod
                               paraMethod:(ParaMethod)paraMethod
                        returnValueMethod:(ReturnValueMethod)returnValueMethod
                                      key:(NSString *)fileKeyName
                      onCompletionHandler:(HHSoftWebResponseSuccessedBlock)responseSuccessed onFailHandler:(HHSoftWebResponseFailBlock)responseFail;

/**
 *  批量上传文件（以文件地址的方式上传）
 *
 *  @param interfaceUrlPath  接口地址
 *  @param filePathArray     文件地址的数组
 *  @param parasDict         参数字典
 *  @param requestmethod     请求方式
 *  @param fileKeyName       文件的key值
 *  @param responseSuccessed 请求成功后返回值处理
 *  @param responseFail      请求失败后返回值处理
 *
 *  @return
 */
-(NSURLSessionDataTask *)uploadBatchFileWithPath:(NSString *)interfaceUrlPath
                                 filePathArray:(NSMutableArray *)filePathArray
                                     parmarDic:(NSMutableDictionary *)parasDict
                                        method:(HTTPMethod)requestmethod
                                    paraMethod:(ParaMethod)paraMethod
                             returnValueMethod:(ReturnValueMethod)returnValueMethod
                                           key:(NSString *)fileKeyName
                           onCompletionHandler:(HHSoftWebResponseSuccessedBlock)responseSuccessed
                                 onFailHandler:(HHSoftWebResponseFailBlock)responseFail;
/**
 *  上传文件（以字节的形式上传）
 *
 *  @param interfaceUrlPath  接口地址
 *  @param fileData          文件的Data
 *  @param fileName          文件的名称
 *  @param parasDict         参数字典
 *  @param requestmethod     请求方式
 *  @param fileKeyName       文件的key值
 *  @param responseSuccessed 请求成功后返回值处理
 *  @param responseFail      请求失败后返回值处理
 *
 *  @return
 */
-(NSURLSessionDataTask *)uploadFileWithUrlPath:(NSString *)interfaceUrlPath
                                    fileData:(NSData *)fileData
                                    fileName:(NSString *)fileName
                                   parmarDic:(NSMutableDictionary *)parasDict
                                      method:(HTTPMethod)requestmethod
                                  paraMethod:(ParaMethod)paraMethod
                           returnValueMethod:(ReturnValueMethod)returnValueMethod
                                         key:(NSString *)fileKeyName
                         onCompletionHandler:(HHSoftWebResponseSuccessedBlock)responseSuccessed
                               onFailHandler:(HHSoftWebResponseFailBlock)responseFail;
/**
 *  批量上传文件（以字节的方式上传）
 *
 *  @param interfaceUrlPath  接口地址
 *  @param arrFileData       文件的Data的数组
 *  @param parasDict         参数字典
 *  @param requestmethod     请求方式
 *  @param fileKeyName       文件的key值
 *  @param responseSuccessed 请求成功后返回值处理
 *  @param responseFail      请求失败后返回值处理
 *
 *  @return
 */
-(NSURLSessionDataTask *)uploadBatchFileWithUrlPath:(NSString *)interfaceUrlPath
                                    fileDataArray:(NSMutableArray *)arrFileData
                                    fileNameArray:(NSMutableArray *)arrFileName
                                        parmarDic:(NSMutableDictionary *)parasDict
                                           method:(HTTPMethod)requestmethod
                                       paraMethod:(ParaMethod)paraMethod
                                returnValueMethod:(ReturnValueMethod)returnValueMethod
                                              key:(NSString *)fileKeyName
                              onCompletionHandler:(HHSoftWebResponseSuccessedBlock)responseSuccessed
                                    onFailHandler:(HHSoftWebResponseFailBlock)responseFail;
/**
 *  批量上传文件（以文件地址的方式上传,多键值对上传）
 *
 *  @param interfaceUrlPath  接口地址
 *  @param filePathArray     文件地址的数组
 *  @param parasDict         参数字典
 *  @param requestmethod     请求方式
 *  @param fileKeyName       文件的key值
 *  @param responseSuccessed 请求成功后返回值处理
 *  @param responseFail      请求失败后返回值处理
 *  @param UpLoadTag         上传文件的标识
 *  @return
 */
-(NSURLSessionDataTask *)uploadBatchFileWithUrlPath:(NSString *)interfaceUrlPath
                                       filePathDict:(NSDictionary *)dictFilePath
                                          parmarDic:(NSMutableDictionary *)parasDict
                                             method:(HTTPMethod)requestmethod
                                         paraMethod:(ParaMethod)paraMethod
                                  returnValueMethod:(ReturnValueMethod)returnValueMethod
                                onCompletionHandler:(HHSoftWebResponseSuccessedBlock)responseSuccessed
                                      onFailHandler:(HHSoftWebResponseFailBlock)responseFail
                                          uploadTag:(UpLoadTag)uploadTag;

/**
 *  批量上传文件（以字节的方式上传,多键值对上传）
 *
 *  @param interfaceUrlPath  接口地址
 *  @param arrFileData       文件的Data的数组
 *  @param parasDict         参数字典
 *  @param requestmethod     请求方式
 *  @param fileKeyName       文件的key值
 *  @param responseSuccessed 请求成功后返回值处理
 *  @param responseFail      请求失败后返回值处理
 *  @param UpLoadTag         上传文件的标识
 *  @return
 */
-(NSURLSessionDataTask *)uploadBatchFileWithUrlPath:(NSString *)interfaceUrlPath
                                       fileDataDict:(NSDictionary *)dictFileData
                                       fileNameDict:(NSDictionary *)dictFileName
                                          parmarDic:(NSMutableDictionary *)parasDict
                                             method:(HTTPMethod)requestmethod
                                         paraMethod:(ParaMethod)paraMethod
                                  returnValueMethod:(ReturnValueMethod)returnValueMethod
                                onCompletionHandler:(HHSoftWebResponseSuccessedBlock)responseSuccessed
                                    onFailHandler:(HHSoftWebResponseFailBlock)responseFail
                                          uploadTag:(UpLoadTag)uploadTag;


/**
 *  下载文件
 *
 *  @param interfaceUrlPath  接口地址
 *  @param parasDict         参数字典
 *  @param requestmethod     请求方式
 *  @param downloadSuccessed 请求成功后返回值处理
 *  @param responseFail      请求失败后返回值处理
 *
 *  @return 
 */
-(NSURLSessionDataTask *)downLoadFileWithUrlPath:(NSString *)interfaceUrlPath
                                      targetPath:(NSString *)targetPath
                                     parmarDic:(NSMutableDictionary *)parasDict
                                        method:(HTTPMethod)requestmethod
                                    paraMethod:(ParaMethod)paraMethod
                             returnValueMethod:(ReturnValueMethod)returnValueMethod
                           onCompletionHandler:(HHSoftWebDownloadFileSuccessBlock)downloadSuccessed
                                 onFailHandler:(HHSoftWebResponseFailBlock)responseFail;


@end
