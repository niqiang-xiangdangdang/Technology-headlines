//
//  ITNews.m
//  Technology-headlines
//
//  Created by NIQIANG on 16/6/8.
//  Copyright © 2016年 NIQIANG. All rights reserved.
//

#import "ITNews.h"

@implementation ITNews

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}

- (NSString *)description{
    return [NSString stringWithFormat:@"id = %@, title = %@ , summary = %@ , src_img = %@ , addtime = %@ , sitename = %@ , docDate = %@",_id,_title,_summary,_src_img,_addtime,_sitename,self.docDate];
}

@end
