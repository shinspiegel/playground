from dataclasses import dataclass
import re


@dataclass
class PwdRuleItem:
    low: int
    high: int
    char: str
    pwd: str

    def is_rule1_ok(self) -> bool:
        return self.low <= self.pwd.count(self.char) <= self.high

    def is_rule2_ok(self) -> bool:
        return (self.pwd[self.low - 1] == self.char) ^ (self.pwd[self.high - 1] == self.char)


def parse_item(line: str) -> PwdRuleItem:
    low, high, char, pwd = re.split('-|: | ', line)
    return PwdRuleItem(int(low), int(high), char, pwd)


pwd_rule_items = [parse_item(line) for line in open("input_big.txt", "r").readlines()]

# Part 1
ok_item_count = len([item for item in pwd_rule_items if item.is_rule1_ok()])
print(f"Part 1: total = {ok_item_count}")

# Part 2
ok_item_count2 = len([item for item in pwd_rule_items if item.is_rule2_ok()])
print(f"Part 2: total = {ok_item_count2}")