import csv

with open("syn.txt") as f:
    with open("syn.csv", "w+", newline='') as c:
        fnames = ["word", "synonym"]
        cw = csv.DictWriter(c, fieldnames = fnames)
        cw.writeheader()
        for line in f:
            words = line[:-1].split(",")
            fword = words[0]
            for word in words[1:]:
                cw.writerow({
                    "word": fword,
                    "synonym": word
                })

