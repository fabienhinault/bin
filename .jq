
# https://github.com/stedolan/jq/blob/master/src/builtin.jq
# https://github.com/stedolan/jq/blob/ca12bd9b5d15c0c4e5bd01d706ddbb3f4edefd36/src/builtin.jq
# Apply f to composite entities recursively, and to atoms
def walk(f):
  . as $in
  | if type == "object" then
      reduce keys_unsorted[] as $key
        ( {}; . + { ($key):  ($in[$key] | walk(f)) } ) | f
  elif type == "array" then map( walk(f) ) | f
  else f
  end;
def toDate1000: . / 1000 | todate;
def showDates: walk(if (type == "number" and . > 1000000000000) then tostring + " " + toDate1000 else . end);

#https://github.com/stedolan/jq/issues/1038
# advance random state
def rand:
    (((214013 * .Seed) + 2531011) % 2147483648) as $Seed | # mod 2^31
    ($Seed / 65536 | floor) as $Bits |  # >> 16
    { $Bits, $Seed }    # 2^15 bits, 2^31 seed
;

# make random state
def randomize($seed):
    { Seed: $seed } | rand | rand
;
def randomize: randomize(now|floor);

# generate stream of random 2^15 values
def rands($state):
    $state | recurse(rand) | .Bits
;
def rands: rands(randomize);

# random integer [0..n)
def random($n; $state):
    $state | rand as $next |
    [ ($next.Bits % $n), $next ]
;
def random($n): random($n; .);

# randomize array contents
def shuffle($state):
    def swap($i; $j):
        if $i == $j
        then .
        else .[$i] as $t | .[$i] = .[$j] | .[$j] = $t
        end;

    . as $array |
    length as $len |
    [limit($len; rands($state))] as $r |
    reduce range($len-1; -1; -1) as $i
        ($array; swap($i; $r[$i] % (1+$i)))
;
def shuffle: shuffle(randomize);
