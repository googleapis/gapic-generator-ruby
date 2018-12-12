# Templates
This directory contains the templates that are used to render a client.
Templates are written in embedded ruby and have the filename extension '.erb'.
Templates can take two forms: a regular template and a utility template.

## Regular Templates
A regular template is a template which will result in a one or multiple output
files. Regular templates will have two objects given to them: a
`Google::Gapic::Schema::Api` object accessed through `@api`, and a
`Google::Gapic::Generator::Util` object accessed through `@util`.

### API information.

The `@api` object gives the template information about the API that is being
generated.

### Utility
The `@util` object gives the template utility methods that is often used in
generating files.

#### Declaring File Names
The templates themselves are responsible for declaring names of the files they
are rendering. This is done in a template by calling the `#file_name` method
on the `@util` object. This allows templates to render multiple files.

For example, rendering a file with the name `hello_world.rb` can be done like
so:

```erb
<%= @util.file_name "hello_world.rb" %>
p 'hello world!'
```

#### Using Utility Templates
The `@util` object also gives exposes utility templates found
in this directory. See the following section to see how to use these templates.

## Utility Templates
A utility template is a template which is used to render common things. Utility
templates should be located in the template directory and their file names
must start with a `_` character. These utility templates are exposed as
Erubis::Eruby objects which can be accessed from the `@util` member by file
name in which the leading `_` and proceeding `.erb` are removed.

Since the templates are exposed as `Erubis::Eruby` objects, to render them from
a regular template, the `#evaluate` method is called.

For example, the `_client.erb` template can be accessed from a regular template
like so:

```erb
<%= @util.client.evaluate(api: @api, util: @util, service: @api.services.first) %>
```

Note that the utility templates are not given `@api`, and `@util` by default. If
the utility template needs access to those members they need to be passed to
them by name in the evaluate method.
