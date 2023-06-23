#!/usr/bin/python3.11

import os

import requests
import subprocess
import argparse
from uuid import uuid4

def main():
    parser = argparse.ArgumentParser(
        prog='tex',
        description='Makes a request to tex-api and some basic utilities based on it.')

    parser.add_argument('-c', '--content', action='store', required=True)
    parser.add_argument('-s', '--save', choices=['file', 'clipboard'], required=True)
    parser.add_argument('-o', '--output', action='store')
    parser.add_argument('-u', '--url', default='<enter a defaulted URL>')

    args = parser.parse_args()
    res = requests.get(args.url, params={
        'content': f'${args.content}$'
    })

    if res.status_code != 200:
        raise RuntimeError(f'Failed to receive the image. Error code: {res.status_code}')

    if args.save == 'file':
        if args.output is not None:
            name = args.output
        else:
            name = f'{uuid4()}.png'

        with open(name, 'wb') as writer:
            writer.write(res.content)
    else:
        name = f'{uuid4()}.png'
        with open(name, 'wb') as writer:
            writer.write(res.content)

        subprocess.run(f"xclip -selection clipboard -t image/png {name}".split())
        os.remove(name)


if __name__ == '__main__':
    main()
