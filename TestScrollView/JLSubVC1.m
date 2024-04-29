//
//  JLSubVC1.m
//  TestScrollView
//
//  Created by jolly2 on 4/29/24.
//

#import "JLSubVC1.h"

@interface JLSubVC1 ()

@end

@implementation JLSubVC1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.scrollBlock) {
        self.scrollBlock(scrollView);
    };
}

@end
