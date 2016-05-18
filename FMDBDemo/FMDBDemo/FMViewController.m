//
//  FMViewController.m
//  FMDBDemo
//
//  Created by Zeno on 16/5/18.
//  Copyright © 2016年 zenoV. All rights reserved.
//

#import "FMViewController.h"
#import "DataBase.h"
#import "Person.h"
#import "Car.h"
#import "CarViewController.h"
#import "PersonCarsViewController.h"
@interface FMViewController ()


/**
 *  数据源
 */
@property(nonatomic,strong) NSMutableArray *dataArray;


@end

@implementation FMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addData)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"车库" style:UIBarButtonItemStylePlain target:self action:@selector(watchCars)];
    
    
   
    
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    
  
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.dataArray = [[DataBase sharedDataBase] getAllPerson];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc ] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
    }
    
    Person *person = self.dataArray[indexPath.row];
    if (person.number == 0) {
        cell.textLabel.text = person.name;
    }else{
        cell.textLabel.text = [NSString stringWithFormat:@"%@(第%ld次更新)",person.name,person.number];
    }
    
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"age: %ld",person.age];
    
    
    return cell;
    
    
    
}



/**
 *  设置删除按钮
 *
 */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
      if (editingStyle == UITableViewCellEditingStyleDelete){
          
          Person *person = self.dataArray[indexPath.row];
          
          [[DataBase sharedDataBase] deletePerson:person];
          [[DataBase sharedDataBase] deleteAllCarsFromPerson:person];
          
          
          self.dataArray = [[DataBase sharedDataBase] getAllPerson];
          
          [self.tableView reloadData];
          
          
      }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    PersonCarsViewController *pcvc = [[PersonCarsViewController alloc] init];
    pcvc.person = self.dataArray[indexPath.row];
    
    [self.navigationController pushViewController:pcvc animated:YES];
    
    
    
    
//    Person *person = self.dataArray[indexPath.row];
//    
//    person.name = [NSString stringWithFormat:@"%@",person.name];
//    
//    person.age = arc4random_uniform(100) + 1;
//    [[DataBase sharedDataBase] updatePerson:person];
//    
//    self.dataArray = [[DataBase sharedDataBase] getAllPerson];
//    
//    [self.tableView reloadData];
    
}



#pragma mark - Action
/**
 *  添加数据到数据库
 */
- (void)addData{
    
    NSLog(@"addData");
    
    int nameRandom = arc4random_uniform(1000);
    NSInteger ageRandom  = arc4random_uniform(100) + 1;
    
    
    
    
    NSString *name = [NSString stringWithFormat:@"person_%d号",nameRandom];
    NSInteger age = ageRandom;
    
    Person *person = [[Person alloc] init];
    person.name = name;
    person.age = age;
    
    
    [[DataBase sharedDataBase] addPerson:person];
    
    self.dataArray = [[DataBase sharedDataBase] getAllPerson];
    
    
    
    
    
    [self.tableView reloadData];
 
    
}
- (void)watchCars{
    
    CarViewController *carVc = [[CarViewController alloc] init];
    
    [self.navigationController pushViewController:carVc animated:YES];
}


#pragma mark - Getter
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
        
    }
    return _dataArray;
    
}


@end
