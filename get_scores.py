#!/usr/bin/env python3

__author__ = 'Pavel Polishchuk'

import os
import re
import argparse


def main_params(in_dir):
    p = re.compile("^dock[0-9]*$")
    dock_dirs = [d for d in os.listdir(in_dir) if os.path.isdir(os.path.join(in_dir, d)) and re.match(p, d)]
    dock_dirs_number = [int(d[4:]) for d in dock_dirs]
    for d in sorted(dock_dirs_number):
        try:
            v = open(os.path.join(in_dir, 'dock' + str(d), 'score')).readline().strip().split(' ')[-1]
            print(v)
        except FileNotFoundError:
            print('')


def main():
    parser = argparse.ArgumentParser(description='Get scores of best poses from S4MPLE docking.')
    parser.add_argument('-i', '--input_dir', metavar='', required=True,
                        help='dir path with ligands and dock subdirs with results.')

    args = vars(parser.parse_args())
    for o, v in args.items():
        if o == "input_dir": in_dir = v

    main_params(in_dir)


if __name__ == '__main__':
    main()
