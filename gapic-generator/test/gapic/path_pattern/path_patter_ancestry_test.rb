require "gapic/path_pattern"

class PathPatternAncestryTest < Minitest::Test
  def test_named_simple_path_pattern
    pattern = Gapic::PathPattern.parse "foo/{bar}/baz/{bif}"
    assert "foo/{bar}", pattern.parent_pattern
  end

  def test_named_complex_path_pattern
    pattern = Gapic::PathPattern.parse "hello/{foo}~{bar}/worlds/{world}"
    assert "hello/{foo}~{bar}", pattern.parent_pattern
  end

  def test_named_singleton_path_pattern
    pattern = Gapic::PathPattern.parse "foo/{bar}/baz"
    assert "foo/{bar}", pattern.parent_pattern
  end

  def test_positional_simple_pattern
    pattern = Gapic::PathPattern.parse "foo/*/baz/**"
    assert "foo/*", pattern.parent_pattern
  end

  def test_positional_singleton_pattern
    pattern = Gapic::PathPattern.parse "foo/*/baz"
    assert "foo/*", pattern.parent_pattern
  end
end
