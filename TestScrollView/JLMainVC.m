//
//  JLMainVC.m
//  TestScrollView
//
//  Created by jolly2 on 4/29/24.
//

#import "JLMainVC.h"
#import "JLMainCell.h"
#import "JLMainCell1.h"
#import "JLSubVC1.h"
@interface JLMainVC ()


@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) UIScrollView *scrollView;

@end

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight  [UIScreen mainScreen].bounds.size.height
@implementation JLMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addViewControllers];
    [self.tableview registerNib:[UINib nibWithNibName:@"JLMainCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cellId"];
    [self.tableview registerNib:[UINib nibWithNibName:@"JLMainCell1" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cellId1"];

    [self.tableview reloadData];
    
}

#pragma delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        return 200;
    }
    return 2300;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        JLMainCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
        return cell;
    }
    JLMainCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId1" forIndexPath:indexPath];
    [cell.contentView addSubview:self.scrollView];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 1){
        return 80;
    }
    return 0;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 80)];
    view.backgroundColor = [UIColor purpleColor];
    return view;
}

- (void)addViewControllers{
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 2300)];
    JLSubVC1 *testVC0 = [JLSubVC1 new];
    [self addChildVC:testVC0 index:0];
   
    UIViewController *testVC1 = [UIViewController new];
    testVC1.view.backgroundColor = [UIColor orangeColor];
    [self addChildVC:testVC1 index:1];
    
    UIViewController *testVC2 = [UIViewController new];
    testVC2.view.backgroundColor = [UIColor greenColor];
    [self addChildVC:testVC2 index:2];
    
    UIViewController *testVC3 = [UIViewController new];
    testVC3.view.backgroundColor = [UIColor yellowColor];
    [self addChildVC:testVC3 index:3];
    
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.scrollView setPagingEnabled:YES];
    [self.scrollView setBounces:NO];
    
    [self.scrollView setContentSize:CGSizeMake(kScreenWidth * self.childViewControllers.count, 0)];
    [self.scrollView setScrollEnabled:YES];
}
- (void)addChildVC:(UIViewController *)controller index:(NSInteger )index{
    [self addChildViewController:controller];
    controller.view.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    controller.view.frame = CGRectMake(kScreenWidth*index, 0, kScreenWidth, kScreenHeight);
    [self.scrollView addSubview:controller.view];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
   
//    CGFloat y = [self.tableview rectForSection:1].origin.y;
//    if(scrollView == self.tableview){
//        if(scrollView.contentOffset.y>=y){
//            [scrollView setContentOffset:CGPointMake(0, y)];
//            scrollView.scrollEnabled = NO;
//            self.scrollView.scrollEnabled = YES;
//        }else{
//            scrollView.scrollEnabled = YES;
//            self.scrollView.scrollEnabled = NO;
//        }
//    }
    
    
}


@end
