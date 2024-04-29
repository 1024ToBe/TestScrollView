//
//  JLSubVC1.h
//  TestScrollView
//
//  Created by jolly2 on 4/29/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JLSubVC1 : UIViewController
/// scrollViewDidScroll 回调
@property (nonatomic, copy) void(^scrollBlock)(UIScrollView *scrollView);
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

NS_ASSUME_NONNULL_END
