from pytest import mark, fixture
from operator import itemgetter
from db.templates import Templates

TEST_CASES = [
    {
        "mod": 1,
        "expected": [(1,), (2,), (3,), (4,)],
    },
    {
        "mod": 2,
        "expected": [(2,), (4,)],
    },
    {
        "mod": 3,
        "expected": [(3,)],
    },
]


@fixture
def instance():
    instance = Templates()
    return instance


@mark.parametrize("params", TEST_CASES)
def test_basic_tpl(instance, params):
    [mod, expected] = itemgetter("mod", "expected")(params)
    response = instance.fromSqlFile("mod.tpl.sql", [mod])
    print(response)
    assert response == expected
