//
//  PersonCarsViewController.m
//  FMDBDemo
//
//  Created by Zeno on 16/5/18.
//  Copyright © 2016年 zenoV. All rights reserved.
//

#import "PersonCarsViewController.h"
#import "Person.h"
#import "Car.h"
#import "DataBase.h"
@interface PersonCarsViewController ()


@property(nonatomic,strong) NSMutableArray *carArray;

@end

@implementation PersonCarsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = [NSString stringWithFormat:@"%@的所有车",self.person.name];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addCar)];
    
    
    self.carArray = [[DataBase sharedDataBase ] getAllCarsFromPerson:self.person];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.carArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"personcarscell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"personcarscell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    Car *car = self.carArray[indexPath.row];
    
    cell.textLabel.text = car.brand;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"price: ￥%ld " ,car.price];
    return cell;
    
    
}
/**
 *  设置删除按钮
 *
 */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete){
        
        Car *car = self.carArray[indexPath.row];
        
        NSLog(@"car.id--%@,own_id--%@",car.car_id,car.own_id);
        [[DataBase sharedDataBase] deleteCar:car fromPerson:self.person];
        
        
        self.carArray = [[DataBase sharedDataBase] getAllCarsFromPerson:self.person];
        
        [self.tableView reloadData];
        
        
    }
    
    
}

#pragma mark - Action
- (void)addCar{
    NSLog(@"添加车辆");

    
    
    Car *car = [[Car alloc] init];
    car.own_id = self.person.ID;
    
    NSArray *brandArray = [NSArray arrayWithObjects:@"大众",@"宝马",@"奔驰",@"奥迪",@"保时捷",@"兰博基尼", nil];
    NSInteger index = arc4random_uniform((int)brandArray.count);
    car.brand = [brandArray objectAtIndex:index];
    
    car.price = arc4random_uniform(1000000);
    
    [[DataBase sharedDataBase] addCar:car toPerson:self.person];
    
    self.carArray = [[DataBase sharedDataBase] getAllCarsFromPerson:self.person];
    
    
    
    [self.tableView reloadData];
    
    
    
    
}

#pragma mark - Getter
- (NSMutableArray *)carArray{
    if (!_carArray) {
        _carArray = [[NSMutableArray alloc] init];
    }
    return _carArray;
    
}



@end
