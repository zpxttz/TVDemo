//
//  ViewController.m
//  TVDemo
//
//  Created by zpx on 2017/2/13.
//  Copyright © 2017年 zpx. All rights reserved.
//

#import "ViewController.h"
#import "demoCell.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, strong) NSMutableDictionary *heightAtIndexPath;//缓存高度所用字典
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    demoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"demoCellID"];
    if (indexPath.row == 1) {
        cell.contentLB.text = @"-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath";
        cell.contentLB1.text = @"-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath-(UICell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath";
    }else if (indexPath.row % 2 ==0){
        cell.contentLB.text = @"-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath-(UICell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath";
        cell.contentLB2.text = @"-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath";
    }else if (indexPath.row % 3 == 0){
        cell.contentLB.text = @"-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath";
        cell.contentLB1.text = @"-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath";
    }else{
        cell.contentLB.text = @"-(UITableViewCetableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath";
    }
    
    return cell;
    
}

//但是如果我们用了自动计算高度的方法，又调用了tableView的reloadData方法（例如我们的数据有分页的时候，加载完下一页的数据后会去刷新tableView）。这时候就会出现问题，点击状态栏就有几率不能精确滚动到顶部了
- (IBAction)reloadClick:(id)sender {
    
    [self.tableView reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    NSNumber *height = [self.heightAtIndexPath objectForKey:indexPath];
    if (height) {
        return height.floatValue;
    }
    else{
        return 100;
    }
    
}
/*
 解释一下，就是用一个字典做容器，在cell将要显示的时候在字典中保存这行cell的高度。然后在调用estimatedHeightForRowAtIndexPath方法时，先去字典查看有没有缓存高度，有就返回，没有就返回一个大概高度
 */
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSNumber *height = @(cell.frame.size.height);
    [self.heightAtIndexPath setObject:height forKey:indexPath];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
