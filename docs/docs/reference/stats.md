# stats

Atuin can calculate statistics based on your shell history.

## Usage

```
atuin stats [OPTIONS] [PERIOD]...
```

## Options

| Option | Description | Default |
|--------|-------------|--------|
| `-c`, `--count <COUNT>` | How many top commands to list | 10 |
| `-n`, `--ngram-size <SIZE>` | The number of consecutive commands to consider (for analyzing command sequences) | 1 |

## Period

The `PERIOD` argument specifies the time range for statistics. If omitted, statistics are computed for your entire history.

### Built-in periods

| Period          | Description                                            |
|-----------------|--------------------------------------------------------|
| (none) or `all` | Statistics for your entire history                     |
| `today`         | From midnight today until midnight tomorrow (24 hours) |
| `week`          | The last 7 days, ending at midnight today              |
| `month`         | The last 31 days, ending at midnight today             |
| `year`          | The last 365 days, ending at midnight today            |

### Custom date periods

You can also specify a custom starting point, and Atuin computes the stats for **24 hours** from that point.
Date parsing is provided by `interim`, which supports different formats for full or relative dates.

Certain formats rely on the dialect option in your
[configuration](../configuration/config.md#dialect) to differentiate day from month.
Refer to [the module's documentation](https://docs.rs/interim/0.1.0/interim/#supported-formats) for more details on the supported date formats.

Examples:

```
$ atuin stats 2018-04-01
$ atuin stats April 1
$ atuin stats 01/04/22
$ atuin stats last friday
$ atuin stats last thursday 3pm  # between last thursday 3:00pm and the following friday 3:00pm
```

!!! warning "Single-day behavior for month names"
    When you specify a month name like `june`, it is interpreted as **June 1st** of the
    current year, and statistics are computed for that single day only (24 hours).
    This may be unexpected if you wanted statistics for the entire month of June.

    To get stats for an entire month, you would need to query each day individually
    or use the full history stats.

## Examples

### Full history stats

```
$ atuin stats
# or
$ atuin stats all

[▮▮▮▮▮▮▮▮▮▮]  4123  ls
[▮▮▮▮▮▮▮▮  ]  3604  cd
[▮▮▮▮▮     ]  2253  git status
...
Total commands:   8190
Unique commands:  2996
```

### Today's stats

```
$ atuin stats today
```

### Last week's stats

```
$ atuin stats week
```

### Stats for a specific date

```
$ atuin stats last friday

[▮▮▮▮▮▮▮▮▮▮]  127  git status
[▮▮▮▮▮▮▮▮  ]  104  cargo build
...
Total commands:   450
Unique commands:  213
```

### Show top 20 commands

```
$ atuin stats --count 20
```

### Analyze command pairs (bigrams)

With `--ngram-size 2`, Atuin will show the most common pairs of consecutive commands:

```
$ atuin stats --ngram-size 2

[▮▮▮▮▮▮▮▮▮▮]  312  git status | git add
[▮▮▮▮▮▮▮   ]  245  cargo build | cargo test
...
```
