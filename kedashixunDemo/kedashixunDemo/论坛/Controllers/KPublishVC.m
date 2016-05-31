//
//  KPublishVC.m
//  kedashixunDemo
//
//  Created by KZL on 16/5/17.
//  Copyright © 2016年 wangbing. All rights reserved.
//

#import "KPublishVC.h"
#import "UIBarButtonItem+WBCustomButton.h"
#import "KTextView.h"
#import "Const.h"
#import "KTextView.h"
#import "KPhotoView.h"
#import "JKImagePickerController.h"
#import "WBNetworking.h"
#import "WBUserInfo.h"
#import "KTools.h"

@interface KPublishVC () <JKImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *titleTF;

@property (weak, nonatomic) IBOutlet KTextView *contentTextView;

@property (weak, nonatomic) IBOutlet KPhotoView *photoView;

@property (weak, nonatomic) IBOutlet UIView *locationView;
@property (weak, nonatomic) IBOutlet UILabel *locationlbl;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *photoViewH;
@property (nonatomic, strong) NSMutableArray   *assetsArray;


@end

@implementation KPublishVC

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [_contentTextView becomeFirstResponder];
}


- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self setNavBarTitleWithText:@"发布主题" withFontSize:20 withTextColor:[UIColor whiteColor]];
    
    self.navigationItem.leftBarButtonItems = [UIBarButtonItem barButtonItemWithImageName:@"arrow_left"  withHighlightedImageName:nil  withTarget:self withAction:@selector(pop) WithNegativeSpacerWidth:-16];
    
    
    self.navigationItem.rightBarButtonItems = [UIBarButtonItem barButtonItemWithTitle:@"发帖" WithTitleColor:[UIColor whiteColor] WithTitleHighlightColor:[UIColor whiteColor] withTarget:self withAction:@selector(publishTopic) WithNegativeSpacerWidth:-4];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(UIKeyBoardShouldReturn:)];
    [self.view addGestureRecognizer:tap];
    
    UITapGestureRecognizer *tapLocation = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapLocation)];
    [self.locationView addGestureRecognizer:tapLocation];
    
    [self viewLayout];

}

#pragma mark --- 添加键盘回退手势

- (void)UIKeyBoardShouldReturn:(UITapGestureRecognizer *)tap{
    
    
    [_titleTF resignFirstResponder];
    [_contentTextView resignFirstResponder];
}

#pragma mark --- 点击地点获取地理位置信息
- (void)tapLocation{
    
    
    
}

- (void)viewLayout{
    
    _contentTextView.placeholder = @"输入正文内容";
     [_photoView.addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)addButtonClick {
    
    JKImagePickerController *imagePickerController = [[JKImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.showsCancelButton = YES;
    imagePickerController.allowsMultipleSelection = YES;
    imagePickerController.minimumNumberOfSelection = 1;
    imagePickerController.maximumNumberOfSelection = 9;
    imagePickerController.selectedAssetArray = self.assetsArray;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:imagePickerController];
    [self presentViewController:navigationController animated:YES completion:NULL];
    
}

#pragma mark ---  JKImagePickerControllerDelegate
- (void)imagePickerControllerDidCancel:(JKImagePickerController *)imagePicker{
    
    [imagePicker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)imagePickerController:(JKImagePickerController *)imagePicker didSelectAssets:(NSArray *)assets isSource:(BOOL)source{
    
    self.assetsArray = [NSMutableArray arrayWithArray:assets];
    self.photoView.assetsArray = self.assetsArray;

    [imagePicker dismissViewControllerAnimated:YES completion:^{
        [self.photoView.collectionView reloadData];
    }];
    
}


- (void)pop{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark --- 发布帖子

- (void)publishTopic{
    
    if (_contentTextView.text.length | (self.assetsArray.count>0)) {
        
        NSDictionary *dic = @{@"uid":[NSString stringWithFormat:@"%d",[WBUserInfo share].userid],@"date":[KTools currentDate],@"place":@"河南科技大学",@"content":_contentTextView.text,@"images":@"",@"looknum":@"0",@"supportnum":@"0"};
        
        [WBNetworking networkRequstWithNetworkRequestMethod:GetNetworkRequest networkRequestStyle:NetType_getAddforum params:dic successBlock:^(id returnData) {
            
            //pop
            [self pop];
            
        } failureBlock:^(NSError *error) {
            
        }];
        
    }else{
        
        
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
