//
//  Car.h
//  FMDBDemo
//
//  Created by Zeno on 16/5/18.
//  Copyright © 2016年 zenoV. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Car : NSObject
/**
 *  所有者
 */
@property(nonatomic,strong ) NSNumber *own_id;

/**
 *  车的ID
 */
@property(nonatomic,strong) NSNumber *car_id;


@property(nonatomic,copy) NSString *brand;

@property(nonatomic,assign) NSInteger price;


@end
