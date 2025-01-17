################################
### WRITE MetSim Config file ###
################################

#Declare list of snotel station numbers
@SID=qw(308 310 416 488 511 519 617 640 861 877 705 866 902 927 969 391 462 463 473 508 518 539 541 587 771 846 848 356 446 540 575 697 724 778 784 809 834 428 301 574 633 977 335 378 386 408 415 430 438 467 551 564 565 629 682 701 825 838 840 842 869 305 303 322 327 369 380 412 431 457 485 505 531 538 542 556 580 586 589 607 618 624 663 680 688 713 718 762 802 857 870 669 737 345 409 426 465 622 632 658 709 717 739 780 793 797 827 839 843 874 675 829 387 773 547 602 904 905 913 914 940 938 936 935 937 939 970 1005 1014 306 423 439 484 490 496 534 535 594 627 637 645 749 761 770 774 803 805 830 845 312 319 320 323 324 338 359 424 450 471 489 492 493 524 537 546 550 600 601 610 620 636 638 639 650 654 677 704 738 740 752 782 792 855 860 867 466 520 588 735 747 411 425 370 769 695 741 623 871 382 895 915 2029 978 988 989 979 926 1016 578 349 754 328 385 480 530 670 781 924 254 437 609 657 722 917 727 835 836 311 918 516 649 932 847 482 604 930 407 448 500 576 664 787 347 414 813 858 410 487 862 381 413 355 469 510 613 662 693 700 760 850 307 318 360 363 403 427 568 690 725 876 313 315 433 436 562 603 635 656 696 458 646 753 893 590 667 346 783 919 903 1008 901 365 1009 916 929 981 316 394 486 532 595 665 715 755 757 491 708 744 678 854 921 922 933 934 1017 321 336 417 453 503 548 573 615 746 334 337 373 445 476 498 527 569 570 652 698 811 849 454 340 443 1006 304 344 357 361 362 434 483 504 523 526 545 552 563 584 605 655 666 712 726 733 767 800 801 810 873 343 477 479 759 812 331 341 351 388 395 398 401 406 422 440 442 464 470 494 529 558 608 614 619 647 651 653 660 671 687 706 710 719 721 729 736 743 745 756 789 794 815 821 302 925 945 1000 1010 330 332 339 364 368 371 374 392 393 399 400 432 435 444 455 474 495 514 517 533 543 559 561 566 513 582 592 612 634 643 684 691 714 742 763 790 795 820 823 828 833 844 864 865 329 333 348 390 396 475 481 557 572 579 621 626 686 720 723 853 521 522 528 694 366 383 452 461 583 593 596 628 631 814 766 896 906 907 971 972 983 1013 375 591 606 642 681 804 832 352 376 418 420 507 515 672 692 699 711 728 788 791 824 841 863 478 553 679 702 748 776 502 734 777 707 630 817 599 648 644 897 898 899 908 910 909 911 912 928 941 943 942 975 974 985 984 990 1012 342 353 358 379 389 402 451 499 506 525 571 577 585 625 668 673 689 703 730 751 772 779 798 806 852 314 325 326 350 367 377 384 449 468 472 512 544 554 560 597 616 676 683 716 731 765 822 826 837 868 872 875 878 851 419 405 786 460 509 555 661 775 831 317 732 859 807 819 497 816 764 501 818 923 931 944 1046 982 1015);

#Calculate the length of this list
$length= @SID;
# $length=1;

#iterate through the series and create names for output files and file control variables 
	for($TT=0; $TT<$length; $TT+=1)
	{			
	$ID=@SID[$TT];
	
	#declare strings for file creation and setting paths	
	$name = "snotel_";
	$period = ".";
	$under = "_";
	$nc = ".nc";
	$dom = "_domain";
	$sta = "_state";
	$for = "_forcing";
	
	#concatenate strings to set file names
	$file = $name . $ID . ".conf";
	$fileout = $name . $ID;
	
	#concatenate strings to set file paths
	$domain = $name . $ID . $dom . $nc;
	$state = $name . $ID . $sta . $nc;
	$forcing = $name . $ID . $for . $nc;
	
	#write .conf information to file variables written to file are marked with "$"
	open(CODE, ">$file");
	print CODE <<"END";
    
# This is an example of an input file for MetSim
[MetSim]
#out_vars = ['temp', 'prec', 'shortwave', 'longwave', 'vapor_pressure', 'rel_humid', 'air_pressure', 'wind']
out_vars = ['temp', 'prec', 'shortwave', 'longwave', 'vapor_pressure', 'rel_humid', 'air_pressure']

# Time step in minutes
time_step = 60

# Forcings begin here (year/month/day:hour) (hour optional)
start = 2017/1/1
; start = 2018/8/1

# Forcings end at this date (year/month/day)
stop = 2018/8/31
; stop = 2018/8/31

# Input and output directories
; forcing = ../metsim/data/test.nc
forcing = $forcing
; domain  = ../metsim/data/domain.nc
domain  = $domain
; state = ../metsim/data/state_nc.nc
state = $state

forcing_fmt = netcdf
in_format = netcdf

out_dir = 
out_prefix = $fileout
; out_freq = 1

; prec_type = triangle
prec_type = uniform
utc_offset = False

[chunks]
lat = 1
lon = 1

[forcing_vars]
prec  = Prec
t_max = Tmax
t_min = Tmin
# wind  = wind

[state_vars]
prec  = prec
t_max = t_max
t_min = t_min

[domain_vars]
lat  = lat
lon  = lon
mask = mask
elev = elev
; t_pk = t_pk
; dur  = dur
  		
END
close(CODE);

}
