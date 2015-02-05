//
//  ViewController.m
//  tick-tack-toe
//
//  Created by pivotal on 2/3/15.
//  Copyright (c) 2015 blahm. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewCell.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIAlertViewDelegate>

@property (assign,nonatomic) BOOL useO;
@property (strong, nonatomic) NSMutableArray *rowScores;
@property (strong, nonatomic) NSMutableArray *columnScores;
@property (assign, nonatomic) NSInteger diagonalScore;
@property (assign, nonatomic) NSInteger antiDiagonalScore;

@end


@implementation ViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self resetScores];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil]
          forCellWithReuseIdentifier:@"Cell"];
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 9;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    [cell reset];
    return cell;
}

#pragma mark - <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = floorf(CGRectGetWidth(self.collectionView.frame) / 3) - 6;
    return CGSizeMake(width, width);
}

#pragma mark - <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = (CollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (cell.empty){
        if (self.useO) {
            [cell displayO];
            self.useO = NO;
            [self incrementScore:-1 forIndex:indexPath.row];
        } else {
            self.useO = YES;
            [cell displayX];
            [self incrementScore:1 forIndex:indexPath.row];
        }
    }
}

#pragma mark - <UIAlertViewDelegate>

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self clearBoard];
}

#pragma mark - Private

- (void)incrementScore:(NSInteger)score forIndex:(NSInteger)index {
    NSInteger row = floor(index/3);
    NSInteger column = index % 3;
    self.rowScores[row] = @([self.rowScores[row] integerValue] + score); // have to convert to NSNumber because array is a collection of pointers, but can't do math with NSNumbers (only with NSIntegers or NSDecimalNumbers for precision)
    self.columnScores[column] = @([self.columnScores[column] integerValue] + score);
    if (row == column) {
        self.diagonalScore += score;
    }
    if (row + column == 2){
        self.antiDiagonalScore += score;
    }
    
    if ([self checkForWinner] == PlayerTypeO || [self checkForWinner] == PlayerTypeX) {
        [self displayWinner: [self checkForWinner]];
    } else if ([self checkForDraw]) {
        [self displayDraw];
    }
}

- (PlayerType)checkForWinner {
    if ([self.rowScores containsObject:@3] || [self.columnScores containsObject:@3] || self.diagonalScore == 3 || self.antiDiagonalScore == 3) {
        return PlayerTypeX;
    }
    if ([self.rowScores containsObject:@(-3)] || [self.columnScores containsObject:@(-3)] ||self.diagonalScore == -3 || self.antiDiagonalScore == -3) {
        return PlayerTypeO;
    }
    return PlayerTypeNone;
}

- (BOOL)checkForDraw {
    for (CollectionViewCell *cell in  self.collectionView.visibleCells) {
        if (cell.empty) {
            return NO;
        }
    }
    return YES;
}

- (void)displayWinner: (PlayerType)playerType {
    NSString *player = @"Player X";
    if (playerType == PlayerTypeO) { player = @"Player O"; }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"WINNER!"
                                                    message:[NSString stringWithFormat:@"%@ %@", player, @"won!"]
                                                   delegate:self
                                          cancelButtonTitle:@"Play again"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)displayDraw {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Draw!"
                                                    message:@"No one wins. Everyone loses! 😈"
                                                   delegate:self
                                          cancelButtonTitle:@"Play again"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)clearBoard {
    [self resetScores];
    [self.collectionView reloadData];
}

- (void)resetScores {
    self.useO = NO;
    self.rowScores = [NSMutableArray arrayWithObjects:@0, @0, @0, nil];
    self.columnScores = [NSMutableArray arrayWithObjects:@0, @0, @0, nil]; // have to end arrayWithObjects: with nil
    self.diagonalScore = 0;
    self.antiDiagonalScore = 0;
}

@end
