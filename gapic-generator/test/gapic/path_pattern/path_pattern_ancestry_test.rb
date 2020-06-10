require "gapic/path_pattern"

class PathPatternAncestryTest < Minitest::Test
  def test_simple_pattern_without_parent
    pattern = Gapic::PathPattern.parse "foo/{bar}"
    assert "foo/*", pattern.template
    assert_nil pattern.parent_template
  end

  def test_named_simple_path_pattern
    pattern = Gapic::PathPattern.parse "foo/{bar}/baz/{bif}"
    assert "foo/*/bar/*", pattern.template
    assert "foo/*", pattern.parent_template
  end

  def test_named_complex_path_pattern
    pattern = Gapic::PathPattern.parse "hello/{foo}~{bar}/worlds/{world}"
    assert "hello/*/worlds/*", pattern.template
    assert "hello/*", pattern.parent_template
  end

  def test_named_singleton_path_pattern
    pattern = Gapic::PathPattern.parse "foo/{bar}/baz"
    assert "foo/*/baz", pattern.template
    assert "foo/*", pattern.parent_template
  end

  def test_positional_simple_pattern
    pattern = Gapic::PathPattern.parse "foo/*/baz/**"
    assert "foo/*/baz/**", pattern.template
    assert "foo/*", pattern.parent_template
  end

  def test_positional_singleton_pattern
    pattern = Gapic::PathPattern.parse "foo/*/baz"
    assert "foo/*/baz", pattern.template
    assert "foo/*", pattern.parent_template
  end
end
