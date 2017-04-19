//
//  HHSoftSandBox.h
//  HHSoftFrameWorkKit
//
//  Created by dgl on 15-3-9.
//  Copyright (c) 2015年 hhsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    DirectoryDocuments=0,//Documents文件夹
    DirectoryTmp=1,//tmp文件夹
    DirectoryCaches=2//Caches文件夹
} DirectoryName;

@interface HHSoftSandBox : NSObject


/**
 *  获取应用程序根路径
 *
 *  @return 应用程序的根路径
 */

#pragma mark -获取应用程序根路径
+(NSString *)PathOfHomeDir;
/**
 *  获取documens路径
 *
 *  @return documens目录路径
 */
#pragma mark -获取documens路径
+(NSString *)PathOfDocuments;
/**
 *  获取tem文件夹的路径
 *
 *  @return tmp目录路径
 */
#pragma mark -获取tmp文件夹的路径
+(NSString *)PathOfTmp;
/**
 *  获取caches文件夹
 *
 *  @return caches目录路径
 */
#pragma mark -获取caches文件夹的路径
+(NSString *)PathOfCaches;
/**
 *  获取文件在沙盒文件夹下的路径
 *
 *  @param filePath      filePath为相对路径 e.g.   111/123/111.txt
 *  @param directoryName 沙盒目录名
 *
 *  @return 文件的全路径
 */
#pragma mark -获取文件在沙盒文件夹下的路径
+(NSString *)FindFullFilePathWithFilePath:(NSString *)filePath byAppendDirectoryName:(DirectoryName)directoryName;


/**
 *  根据文件相对路径获取文件
 *
 *  @param filePath      文件的相对路径 e.g.   111/123/111.txt
 *  @param directoryName 沙盒目录名
 *
 *  @return 成功返回文件，失败返回nil。
 */
#pragma mark -根据文件相对路径获取文件
+(NSData *)FindFileWithFilePath:(NSString *)filePath byAppendDirectoryName:(DirectoryName)directoryName;


/**
 *  在相应目录下创建一个文件夹。
 *  @param  folder:文件夹名 相对路径 e.g.   111/123
 *  @param  directoryName:沙盒目录名
 *  return  成功返回YES，失败返回NO。若已存在直接返回YES。
 */
#pragma mark -在相应目录下创建一个文件夹
+ (BOOL)CreateFolder:(NSString *)folder inDirectory:(DirectoryName)directoryName;

/**
 *  保存文件到相应路径下。
 *  @param  data:要保存的数据。
 *  @param  filePath:相对路径 e.g.   111/123/111.txt
 *  @param  directoryName:沙盒目录名
 *  return  成功返回YES，失败返回NO。
 */
#pragma mark -保存文件到相应路径下
+ (BOOL)SaveData:(NSData *)data ToFilePath:(NSString *)filePath inDirectory:(DirectoryName)directoryName;

/**
 *  删除文件。
 *  @param  fileName:要删除的文件名。文件的相对路径 e.g.   111/123/111.txt
 *  @param  directoryName:沙盒目录名
 *  return  成功返回YES，失败返回NO。
 */
#pragma mark -删除文件
+ (BOOL)DeleteFile:(NSString *)fileName inDirectory:(DirectoryName)directoryName;

@end
