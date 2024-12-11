export default function (plop) {
    plop.setGenerator('new day', {
        description: 'create directory and files for a new day',
        prompts: [{
            type: 'input',
            name: 'day',
            message: 'Problem number?'
        }],
        actions: [
            {
                type: 'add',
                path: 'lib/problem{{day}}/problem{{day}}.ex',
                templateFile: 'plop-templates/problem.ex.hbs'
            },
            {
                type: 'add',
                path: 'test/problem{{day}}_test.exs',
                templateFile: 'plop-templates/day_test.exs.hbs'
            },
            {
                type: 'add',
                path: 'lib/problem{{day}}/input{{day}}.txt'
            },
            {
                type: 'add',
                path: 'lib/problem{{day}}/input{{day}}_test.txt'
            },
        ]
    });
};