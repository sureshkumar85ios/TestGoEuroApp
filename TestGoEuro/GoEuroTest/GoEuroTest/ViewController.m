//
//  ViewController.m
//  GoEuroTest
//
//  Created by ADDC on 8/2/16.
//  Copyright © 2016 sureshkumar. All rights reserved.
//

#import "ViewController.h"
#import "SegmentLabel.h"
#import "SimpleREST.h"
#import "ChildViewController.h"
#import "MyProject-Swift.h"

#define SCREENWIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
#define BLUECOLOR  [UIColor colorWithRed:15/255.f green:97/255.f blue:163/255.f alpha:1]
#define NAVIHEIGHT 0.1f

@interface ViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *titleScrollView;
@property (nonatomic, strong) UIScrollView *contentScrollView;
@property (nonatomic, strong) UIView       *indicateView;
@property (nonatomic, strong) NSMutableArray *lables;

@property (nonatomic, assign) CGFloat titleLabelWidth;
@property (nonatomic, assign) CGFloat titleHeight;
@property (nonatomic, assign) CGFloat indicateHeight;
@property (nonatomic, assign) CGFloat indicateWidth;
@property (nonatomic, strong) UIColor *indicateColor;

@end

@implementation ViewController

- (NSMutableArray *)lables {
    if (!_lables) {
        _lables = [NSMutableArray array];
    }
    return _lables;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setUp];
    [self sharedInit];
    
//
    Hello *instance = [Hello new];
    [instance sayHello];
    
    [self request];
}

- (void)setUp {
    self.title = @"London-Berlin";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.titleHeight     = 70.0f;
    self.titleLabelWidth = 120.0f;
    self.indicateHeight  = 4.0f;
    self.indicateWidth   = 100.0f;
    self.indicateColor   = [UIColor yellowColor];
    
}

- (void)sharedInit {
    
    self.titleScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAVIHEIGHT, SCREENWIDTH, self.titleHeight)];
    self.titleScrollView.backgroundColor = BLUECOLOR;
    self.titleScrollView.showsHorizontalScrollIndicator = NO;
    
    self.indicateView = [[UIView alloc] initWithFrame:CGRectMake(0, self.titleHeight - self.indicateHeight, self.indicateWidth, self.indicateHeight)];
    self.indicateView.backgroundColor = self.indicateColor;
    
    self.contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.titleHeight + NAVIHEIGHT, SCREENWIDTH, SCREENHEIGHT - self.titleHeight)];
    self.contentScrollView.backgroundColor = [UIColor darkGrayColor];
    self.contentScrollView.pagingEnabled   = YES;
    self.contentScrollView.delegate        = self;
    
    
    [self.titleScrollView addSubview:self.indicateView];
    [self.view addSubview:self.titleScrollView];
    [self.view addSubview:self.contentScrollView];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [backButton setImage:[UIImage imageNamed:@"discount-2.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(discountAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
}

-(IBAction)discountAction:(id)sender
{
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Discount!"
                                  message:@"Offer details are not yet implemented!"
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             
                         }];

    
    [alert addAction:ok];
    
    [self presentViewController:alert animated:YES completion:nil];

}

- (void)request {
    NSArray *titleArray = @[@"Flights",@"Trains",@"Bus"];
    NSArray *imgArray = @[@"train",@"flight",@"bus"];

    
    NSArray *URLArray =  @[@"https://api.myjson.com/bins/w60i",@"https://api.myjson.com/bins/3zmcy",@"https://api.myjson.com/bins/37yzm"];
   
    SimpleREST *simple = [[SimpleREST alloc]init];
   
    for (int i = 0; i < titleArray.count; i++) {
        
        SegmentLabel *titleLabel = [[SegmentLabel alloc] init];
        [titleLabel setFont:[UIFont fontWithName:@"GillSans" size:15]];
        
        UIImageView *imgView = [[UIImageView alloc] init];
        
        titleLabel.text = titleArray[i];
        titleLabel.frame = CGRectMake(self.titleLabelWidth * i-5, 15, self.titleLabelWidth, self.titleHeight);
        imgView.frame=CGRectMake(self.titleLabelWidth * i+45, 10, 20,20);
        [imgView setImage:[UIImage imageNamed:[imgArray objectAtIndex:i]]];
        titleLabel.userInteractionEnabled = YES;
        titleLabel.tag = i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [titleLabel addGestureRecognizer:tap];
        [self.titleScrollView addSubview:titleLabel];
        [self.titleScrollView addSubview:imgView];
        [self.lables addObject:titleLabel];
        
        if (titleLabel.tag == 0) {
            titleLabel.scale = 1.0f;
        }
        
    
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        
        ChildViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"ViewController1"];
        viewController.title = titleArray[i];
        viewController.arrayValues = [simple Get:URLArray[i] params:nil];
        [self addChildViewController:viewController];
        
        
    }
    
    
    

    self.titleScrollView.contentSize   = CGSizeMake(self.titleLabelWidth * titleArray.count, 0);
    self.contentScrollView.contentSize = CGSizeMake(SCREENWIDTH * titleArray.count, 0);
    
    [self scrollViewDidEndScrollingAnimation:self.contentScrollView];
}

- (void)tap:(UITapGestureRecognizer *)recognizer {
    NSInteger index = recognizer.view.tag;
    NSLog(@"%ld",index);
    
    CGPoint offset = self.contentScrollView.contentOffset;
    offset.x = index * self.contentScrollView.frame.size.width;
    [self.contentScrollView setContentOffset:offset animated:YES];
    
}

#pragma mark - <UIScrollViewDelegate>

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    CGFloat width   = scrollView.frame.size.width;
    CGFloat height  = scrollView.frame.size.height;
    CGFloat offsetX = scrollView.contentOffset.x;
    
    NSInteger index = offsetX / width;
    
    UILabel *titleLabel      = [self.titleScrollView viewWithTag:index];;
    CGPoint titleLabelOffset = self.titleScrollView.contentOffset;
    titleLabelOffset.x       = titleLabel.center.x - width * 0.5;
    
    CGRect indicateFrame   = self.indicateView.frame;
    indicateFrame.origin.x = titleLabel.frame.origin.x;
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.indicateView.frame = indicateFrame;
    } completion:^(BOOL finished) {
    }];
    
    if (titleLabelOffset.x < 0) {
        titleLabelOffset.x = 0;
    }
    CGFloat maxTitleOffsetX = self.titleScrollView.contentSize.width - width;
    if (titleLabelOffset.x > maxTitleOffsetX) {
        titleLabelOffset.x = maxTitleOffsetX;
    }
    
    [self.titleScrollView setContentOffset:titleLabelOffset animated:YES];
    
    UIViewController *willShowVc = self.childViewControllers[index];
    if ([willShowVc isViewLoaded]) return;
    
    willShowVc.view.frame = CGRectMake(offsetX, 0, SCREENWIDTH, height);
    [scrollView addSubview:willShowVc.view];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat scale = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    if (scale < 0 || scale > self.titleScrollView.subviews.count - 1) return;
    
    NSInteger leftIndex = scale;
    SegmentLabel *leftLabel = self.lables[leftIndex];
    
    NSInteger rightIndex = leftIndex + 1;
    SegmentLabel *rightLabel = (rightIndex == self.lables.count) ? nil : self.lables[rightIndex];
    
    CGFloat rightScale = scale - leftIndex;
    CGFloat leftScale = 1 - rightScale;
    
    leftLabel.scale = leftScale;
    rightLabel.scale = rightScale;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
