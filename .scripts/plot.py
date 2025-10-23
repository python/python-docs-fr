import datetime

from matplotlib import pyplot as plt

r"""Update using something like:

YEAR=2025
for i in $(seq -w 01 12)
do
   git clean -dfqx >/dev/null
   git checkout -- . >/dev/null
   git checkout $(git log 3.14 --after "$YEAR-$i-01" | grep ^commit | tail -n 1 | cut -d' ' -f2) >/dev/null 2>/dev/null
   python -c 'import sys; print("datetime.date({}, {}, {}): {:.1f},".format(int(sys.argv[3]), int(sys.argv[4]), int(sys.argv[5]), 100 * int(sys.argv[1]) / int(sys.argv[2])))' \
       "$(ls -1 *.po */*.po | grep -v 'whatsnew/changelog\|whatsnew/2\|whatsnew/3.[0-8]\|setupscript.po\|random.po\|typing.po' | xargs msgcat -u --use-first | msgattrib --translated | grep -c '^msgid')" \
       "$(ls -1 *.po */*.po | grep -v 'whatsnew/changelog\|whatsnew/2\|whatsnew/3.[0-8]\|setupscript.po\|random.po\|typing.po' | xargs msgcat -u --use-first | grep -c '^msgid')" \
       $(git show -s --pretty=format:%cs | tr '-' ' ')
done
"""


plt.xkcd()

# According to `make progress`

progress = {
    datetime.date(2012, 10, 1): 0,
    datetime.date(2012, 12, 1): 4,
    datetime.date(2013, 12, 1): 4,
    datetime.date(2014, 11, 1): 4,
    datetime.date(2015, 12, 1): 5,
    datetime.date(2016, 1, 4): 6,  # f8933be
    datetime.date(2016, 2, 1): 15,  # very short untranslatable strings
    datetime.date(2016, 3, 4): 16,  # 18c7d86
    datetime.date(2016, 4, 12): 17,  # 4616b26
    datetime.date(2016, 5, 1): 18,  # dd31bac
    datetime.date(2016, 6, 13): 20,  # d16d992
    datetime.date(2016, 7, 3): 20,  # 9e52ea9
    datetime.date(2016, 10, 17): 20,  # efc39ad...
    # Changement de repo
    datetime.date(2016, 11, 5): 19,  # e61fde28
    datetime.date(2017, 1, 17): 19,  # 384a9e5c
    datetime.date(2017, 3, 5): 19.3,  # 384a9e5c
    datetime.date(2017, 4, 2): 19.5,
    datetime.date(2017, 5, 10): 20,
    datetime.date(2017, 6, 1): 21.3,
    datetime.date(2017, 7, 6): 22.2,
    datetime.date(2017, 8, 1): 22.2,
    datetime.date(2017, 9, 5): 23.3,
    datetime.date(2017, 10, 2): 24.5,
    datetime.date(2017, 11, 5): 26.5,
    datetime.date(2017, 12, 1): 27.1,
    datetime.date(2018, 1, 4): 27.3,
    datetime.date(2018, 1, 30): 27.8,
    datetime.date(2018, 3, 1): 27.8,
    datetime.date(2018, 5, 21): 29.9,
    datetime.date(2018, 7, 2): 30,
    datetime.date(2018, 8, 1): 33,
    datetime.date(2018, 9, 15): 33.2,
    datetime.date(2018, 11, 1): 37.6,
    datetime.date(2018, 12, 7): 39.6,
    datetime.date(2019, 1, 2): 40.1,
    datetime.date(2019, 2, 3): 41,
    datetime.date(2019, 3, 1): 43.2,
    datetime.date(2019, 4, 2): 44.6,
    datetime.date(2019, 5, 6): 45,
    datetime.date(2019, 6, 3): 45.6,
    datetime.date(2019, 7, 2): 47.1,
    datetime.date(2019, 8, 13): 47.4,
    datetime.date(2019, 9, 3): 49.4,
    datetime.date(2019, 9, 30): 47.9,  # Coût du passage en 3.8
    datetime.date(2019, 10, 2): 47.9,
    datetime.date(2019, 11, 1): 48.5,
    datetime.date(2019, 12, 1): 48.8,
    datetime.date(2020, 1, 2): 49.6,
    datetime.date(2020, 2, 1): 50.0,
    datetime.date(2020, 3, 3): 50.9,
    datetime.date(2020, 4, 1): 51.1,
    datetime.date(2020, 5, 1): 51.4,
    datetime.date(2020, 6, 5): 53.2,
    datetime.date(2020, 7, 1): 53.4,
    datetime.date(2020, 8, 4): 52.8,
    datetime.date(2020, 9, 9): 53.4,
    datetime.date(2020, 10, 1): 54.1,
    datetime.date(2020, 11, 6): 54.1,
    datetime.date(2020, 12, 2): 54.1,
    datetime.date(2021, 2, 2): 54.0,
    datetime.date(2021, 3, 1): 54.4,
    datetime.date(2021, 4, 1): 54.8,
    datetime.date(2021, 5, 4): 55.1,
    datetime.date(2021, 6, 4): 56.2,
    datetime.date(2021, 7, 14): 56.4,
    datetime.date(2021, 8, 5): 56.4,
    datetime.date(2021, 9, 6): 56.4,
    datetime.date(2021, 11, 1): 58,
    datetime.date(2022, 1, 27): 58.2,
    datetime.date(2022, 2, 4): 58.2,
    datetime.date(2022, 3, 6): 58.2,
    datetime.date(2022, 4, 5): 57.2,
    datetime.date(2022, 5, 23): 57.2,
    datetime.date(2022, 9, 13): 58.1,
    datetime.date(2022, 10, 27): 58.7,
    datetime.date(2022, 11, 1): 58.7,
    datetime.date(2022, 12, 6): 59.9,
    datetime.date(2023, 1, 2): 60.3,
    datetime.date(2023, 2, 4): 60.2,
    datetime.date(2023, 3, 5): 60.8,
    datetime.date(2023, 4, 1): 61.0,
    datetime.date(2023, 5, 14): 61.3,
    datetime.date(2023, 6, 20): 61.5,
    datetime.date(2023, 7, 4): 61.7,
    datetime.date(2024, 1, 2): 62.8,
    datetime.date(2024, 3, 23): 63.7,
    datetime.date(2024, 4, 3): 64.7,
    datetime.date(2024, 5, 14): 64.7,
    datetime.date(2024, 8, 24): 64.7,
    datetime.date(2024, 10, 1): 64.7,
    datetime.date(2025, 10, 17): 62.2,
}

plt.rcParams["figure.figsize"] = (20, 10)

f, ax = plt.subplots(1)
ax.plot(list(progress.keys()), list(progress.values()), linestyle="-")
ax.annotate(
    "Bump to 3.10",
    (datetime.date(2021, 9, 24), 56.4),
    xytext=(datetime.date(2021, 9, 24), 40),
    arrowprops={"arrowstyle": "->"},
)
ax.annotate(
    "Bump to 3.9",
    (datetime.date(2020, 8, 4), 52.8),
    xytext=(datetime.date(2020, 6, 5), 35),
    arrowprops={"arrowstyle": "->"},
)
ax.annotate(
    "Bump to 3.8",
    (datetime.date(2019, 9, 30), 47.9),
    xytext=(datetime.date(2019, 9, 4), 30),
    arrowprops={"arrowstyle": "->"},
)
ax.annotate(
    "Meetups AFPy mensuels",
    (datetime.date(2018, 9, 1), 29.4),
    xytext=(-10, -40),
    textcoords="offset points",
    arrowprops={"arrowstyle": "->"},
)
ax.annotate(
    "/python/python-docs-fr/",
    (datetime.date(2016, 11, 5), 23.5),
    xytext=(-100, 50),
    textcoords="offset points",
    arrowprops={"arrowstyle": "->"},
)
ax.annotate(
    "Working on very short strings",
    (datetime.date(2016, 1, 15), (6 + 16) / 2),
    xytext=(-10, -50),
    textcoords="offset points",
    arrowprops={"arrowstyle": "->"},
)
plt.ylabel("%")
ax.set_ylim(ymin=0)
plt.savefig("fr_translation_percent.png")
