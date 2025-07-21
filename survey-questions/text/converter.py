import sys
import re
import os
from colorama import Fore, Style


def log(msg: str, level: str = "debug"):
    match level:
        case "none":
            print(msg)
        case "debug":
            print(Fore.BLUE, 'DEBUG', Style.RESET_ALL, msg)
        case "info":
            print(Fore.CYAN, 'INFO', Style.RESET_ALL, msg)
        case "warn":
            print(Fore.YELLOW, 'WARN', Style.RESET_ALL, msg)
        case "error":
            print(Fore.RED, 'ERROR', Style.RESET_ALL, msg)
        case "fatal":
            print(Fore.MAGENTA, 'FATAL', Style.RESET_ALL, msg)
    print(Style.RESET_ALL, end = "")

def open_create(filepath: str, flags):
    return os.open(filepath, flags | os.O_CREAT)

def save_intermediate(question: tuple[str, str], filepath: str):
    with open(filepath, "r+", opener = open_create) as f:
        data = f.read()
        new_question = tuple(question)
        if len(data) != 0:
            questions = eval(data)
            questions.add(new_question)
            f.seek(0)
            f.write(repr(questions))
        else:
            f.write(repr(set([new_question])))

def save_full(questions: set[tuple[str, str]], filepath: str):
    with open(filepath, "w+") as f:
        f.write(repr(questions))

def file_data(filename: str):
    file = open(filename)
    data = []
    for line in file:
        if len(line) == 1:
            continue
        data.append(line)
    file.close()
    return [data]

def process(pages: list[list[str]], intermediate: str) -> set[list[str]]:
    current_question = ""
    questions = set()
    print_last_question = False
    log(f"Ready to review {sum(len(page) for page in pages)} lines?", "info")
    for page_num, page in enumerate(pages):
        log(f"Currently viewing page {page_num + 1} out of {len(pages)}:", "info")
        line_num = 0
        while line_num < len(page):
            line = page[line_num]
            log(f"Currently viewing line {line_num + 1} out of {len(page)}:", "info")
            line_num += 1
            print()
            print(current_question, end = "")
            print(line, end = "")
            print()
            log("What will you do with this line?", "info")
            print("\ta (add to current question)")
            print("\tn (add to next question)")
            print("\ts (skip line: default)")
            print("\tq (quit and save)")
            answer = input("\t[a/n/S/q]: ")
            match answer.upper():
                case "A":
                    current_question += line
                case "N":
                    print()
                    print(current_question)
                    log("What is the type of the last question then?", "info")
                    print("\tmc (multiple choice)")
                    print("\tms (multiple select)")
                    print("\tti (table input)")
                    print("\twr (written response)")
                    print("\tq (quit and save)")
                    question_type = input("\t[mc/ms/ti/wr/q]: ")
                    if question_type.upper() == "Q":
                        return questions
                    questions.add((current_question, question_type.upper()))
                    save_intermediate((current_question, question_type.upper()), intermediate)
                    current_question = ""
                    line_num -= 1
                    print_last_question = True
                case "S" | "":
                    continue
                case "Q":
                    return questions
        print()
    log("Finished.", "info")
    log("What is the type of the last question then?", "info")
    print("\tmc (multiple choice)")
    print("\tms (multiple select)")
    print("\tti (table input)")
    print("\twr (written response)")
    print("\tq (quit and save)")
    question_type = input("\t[mc/ms/ti/wr/q]: ")
    questions.add((current_question, question_type.upper()))
    save_intermediate((current_question, question_type.upper()), intermediate)
    return questions

args = sys.argv[1:]

if len(args) != 1:
    print("Missing name of text file that you would like to process")
    exit(1)

filepath = args[0]
data = file_data(filepath)
questions = process(data, filepath + "_intermediate.txt")
save_full(questions, filepath + "_full.txt")
