//
//  DataBase.h
//  FMDBDemo
//
//  Created by Zeno on 16/5/18.
//  Copyright © 2016年 zenoV. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Person;
@class Car;



@interface DataBase : NSObject

@property(nonatomic,strong) Person *person;


+ (instancetype)sharedDataBase;


#pragma mark - Person
/**
 *  添加person
 *
 */
- (void)addPerson:(Person *)person;
/**
 *  删除person
 *
 */
- (void)deletePerson:(Person *)person;
/**
 *  更新person
 *
 */
- (void)updatePerson:(Person *)person;

/**
 *  获取所有数据
 *
 */
- (NSMutableArray *)getAllPerson;

#pragma mark - Car


/**
 *  给person添加车辆
 *
 */
- (void)addCar:(Car *)car toPerson:(Person *)person;
/**
 *  给person删除车辆
 *
 */
- (void)deleteCar:(Car *)car fromPerson:(Person *)person;
/**
 *  获取person的所有车辆
 *
 */
- (NSMutableArray *)getAllCarsFromPerson:(Person *)person;
/**
 *  删除person的所有车辆
 *
 */
- (void)deleteAllCarsFromPerson:(Person *)person;


@end
