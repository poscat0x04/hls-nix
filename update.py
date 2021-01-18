#! /usr/bin/env nix-shell
#! nix-shell -i python3 -p git python3 python3Packages.pyyaml python3Packages.parse nix-prefetch-git nix-prefetch-github

from yaml import load, dump
from glob import glob
from parse import parse
from pathlib import Path
try:
    from yaml import CLoader as Loader, CDumper as Dumper
except ImportError:
    from yaml import Loader, Dumper
import subprocess
import json
import os
import shutil


def fmt_github(owner, repo):
    url = "https://github.com/{}/{}".format(owner, repo)
    return url


def prefetch_url(url, rev=None):
    args = ["nix-prefetch-git", "--url", url]
    if rev:
        args = args + ["--rev", rev]
    o = subprocess.check_output(args)
    d = json.loads(o)
    return d


def prefetch_github(owner, repo, rev=None):
    url = fmt_github(owner, repo)
    d = prefetch_url(url, rev)
    return d


def prefetch_github_(owner, repo, rev):
    args = ["nix-prefetch-github",
            "--fetch-submodules", "--rev", rev, owner, repo
            ]
    o = subprocess.check_output(args)
    d = json.loads(o)
    return d


def git_clone(url, path):
    args = ["git", "clone", url, path]
    subprocess.call(args)


def git_checkout(ref):
    args = ["git", "checkout", ref]
    subprocess.call(args)


def git_rev():
    args = ["git", "rev-parse", "HEAD"]
    o = subprocess.check_output(args)
    return (o.strip())


def fmt_dep_url(d):
    if "git" in d:
        url = d["git"]
        rev = d["commit"]
        name = url.split("/")[-1]
        return url, rev, name
    else:
        l = d["github"].split("/")
        owner = l[0]
        repo = l[1]
        url = fmt_github(owner, repo)
        rev = d["commit"]
        return url, rev, repo


HLS_REPO = "https://github.com/haskell/haskell-language-server"
TAGS = ["master", "0.1"]
TMP_PATH = "/tmp/hls"


def main():
    git_clone(HLS_REPO, TMP_PATH)
    orig_dir = os.getcwd()
    os.chdir(TMP_PATH)
    for tag in TAGS:
        git_checkout(tag)
        rev = git_rev()
        d = prefetch_github_("haskell", "haskell-language-server", rev)
        src = "{}/source/spec/hls-{}.json".format(orig_dir, tag)
        with open(src, 'w+') as f:
            json.dump(d, f, indent=4, sort_keys=True)
        fs = glob("{}/stack-*.yaml".format(TMP_PATH))
        for f in fs:
            r = parse("{}/stack-{{}}.yaml".format(TMP_PATH), f)
            v = r[0]
            yml = Path("{}/stack-{}.yaml".format(TMP_PATH, v))
            jsn = Path("{}/cache-{}/{}.json".format(orig_dir, tag, v))
            jsn.parents[0].mkdir(parents=True, exist_ok=True)
            with open(yml) as f:
                d = load(f, Loader=Loader)
                deps = d.get("extra-deps")
                r = []
                if deps == None:
                    pass
                else:
                    for i in deps:
                        if isinstance(i, dict):
                            url, rev, name = fmt_dep_url(i)
                            d = prefetch_url(url, rev)
                            r.append({"name": name,
                                      "rev": rev,
                                      "url": url + ".git",
                                      "sha256": d["sha256"]
                                      })
                with open(jsn, 'w+') as f:
                    json.dump(r, f, indent=4, sort_keys=True)


if __name__ == "__main__":
    try:
        main()
        shutil.rmtree(TMP_PATH)
    except Exception as e:
        shutil.rmtree(TMP_PATH)
        raise e
