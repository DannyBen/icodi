![logo](assets/logo.svg)

Icodi - Deterministic Random SVG Icon Generator
==================================================

[![Gem Version](https://badge.fury.io/rb/icodi.svg)](https://badge.fury.io/rb/icodi)
[![Build Status](https://travis-ci.com/DannyBen/icodi.svg?branch=master)](https://travis-ci.com/DannyBen/icodi)

---

Generate repeatable random SVG icons from any string, similar to 
[GitHub identicons].

---

Installation
--------------------------------------------------

    $ gem install icodi



Examples
--------------------------------------------------

### Grid: 5x5, Mirror: X (default options)

![sample](assets/sample-strip-default.svg)

### Grid: 6x6, Mirror: Y

![sample](assets/sample-strip-6y.svg)

### Grid: 8x8, Mirror: X/Y, Density: 0.3

![sample](assets/sample-strip-8xylow.svg)

### Grid: 8x8, Mirror: X/Y, Density: 0.8

![sample](assets/sample-strip-8xyhigh.svg)

### Increasing Stroke: 0.1 - 5.0

![sample](assets/sample-strip-stroke.svg)

### Increasing Density: 0.3 - 0.8

![sample](assets/sample-strip-density.svg)

### Mirror Styles: X, Y, Both, None

![sample](assets/sample-strip-mirrors.svg)


Usage
--------------------------------------------------

This is the general usage pattern:

```ruby
require 'icodi'

# initialize with optional text and options
icon = Icodi.new text, options

# get the SVG string
icon.render

# or save to SVG file
icon.save 'logo'
```

Generate a random icon with the default options, and save it to `icon.svg`:

```ruby
icon = Icodi.new
icon.save 'icon'
```

Generate persistent random icon (same input generates the same output):

```ruby
icon = Icodi.new "any string"
icon.save 'icon'
```

Options
--------------------------------------------------

Soon

---

[GitHub identicons]: https://blog.github.com/2013-08-14-identicons/