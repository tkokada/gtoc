#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'test/unit'
require 'gtoc'


#=== Test for Geographic module.
class GeographicTest < Test::Unit::TestCase

  include Geographic

  def test_semi_major_axis
    assert_equal(A_WORLD, semi_major_axis)
    checker = [{type: "world", expected: A_WORLD},
               {type: "japan", expected: A_JAPAN},
               {type: "no meaning", expected: A_WORLD},
               {type: nil, expected: A_WORLD}]
    checker.each { |t| assert_equal(t[:expected], semi_major_axis(t[:type])) }
  end

  def test_flattening
    assert_equal(F_WORLD, flattening)
    checker = [{type: "world", expected: F_WORLD},
               {type: "japan", expected: F_JAPAN},
               {type: "no meaning", expected: F_WORLD},
               {type: nil, expected: F_WORLD}]
    checker.each { |t| assert_equal(t[:expected], flattening(t[:type])) }
  end

  def test_eccentricity
    assert_equal(Float, eccentricity.class)
    checker = [{type: "world", expected: Float},
               {type: "japan", expected: Float},
               {type: "no meaning", expected: Float},
               {type: nil, expected: Float}]
    checker.each { |t|
      assert_equal(t[:expected], eccentricity(t[:type]).class) }
    checker.each { |t|
      assert_equal(t[:expected],
                   second_eccentricity(t[:type]).class) }
  end

  def test_meridian_arc
    assert_raise(ArgumentError) { meridian_arc }
    checker = [{latitude: 30.0, type: "world", expected: Float},
               {latitude: 30.0, type: "japan", expected: Float},
               {latitude: 30.0, type: "no meaning", expected: Float},
               {latitude: 30.0, type: nil, expected: Float}]
    [-1000.0, -30.0, 0.0, 30.0, 60.0, 90.0, 1000.0].each { |l|
      checker << {latitude: l, type: "world", expected: Float} }
    checker.each { |t|
      assert_equal(t[:expected], meridian_arc(t[:latitude], t[:type]).class) }
  end

  def test_prime_vertical_curvature
    assert_raise(ArgumentError) { prime_vertical_curvature }
    checker = [{latitude: 30.0, type: "world", expected: Float},
               {latitude: 30.0, type: "japan", expected: Float},
               {latitude: 30.0, type: "no meaning", expected: Float},
               {latitude: 30.0, type: nil, expected: Float}]
    [-1000.0, -30.0, 0.0, 30.0, 60.0, 90.0, 1000.0].each { |l|
      checker << {latitude: l, type: "world", expected: Float} }
    checker.each { |t|
      assert_equal(t[:expected],
                   prime_vertical_curvature(t[:latitude], t[:type]).class) }
  end

  def test_meridian_curvature
    assert_raise(ArgumentError) { meridian_curvature }
    checker = [{latitude: 30.0, type: "world", expected: Float},
               {latitude: 30.0, type: "japan", expected: Float},
               {latitude: 30.0, type: "no meaning", expected: Float},
               {latitude: 30.0, type: nil, expected: Float}]
    [-1000.0, -30.0, 0.0, 30.0, 60.0, 90.0, 1000.0].each { |l|
      checker << {latitude: l, type: "world", expected: Float} }
    checker.each { |t|
      assert_equal(t[:expected],
                   meridian_curvature(t[:latitude], t[:type]).class) }
  end

  def test_to_radian
    assert_raise(ArgumentError) { to_radian }
    checker = []
    checker =
      [-1000.0, -30.0, 0.0, 30.0, 60.0, 90.0, 1000.0].inject([]) { |a, r|
      a << {r: r, expected: Float} }
    checker.each { |t| assert_equal(t[:expected], to_radian(t[:r]).class) }
  end

  def test_gtoc
    assert_raise(NoMethodError) { gtoc }
    checker = [
      {latitude: 33.0, longitude: 129.5, number: 1, type: "japan",
       expected_x: Float, expected_y: Float, expected_m: Float},
      {latitude: 33.0, longitude: 129.5, number: 1, type: "world",
       expected_x: Float, expected_y: Float, expected_m: Float},
      {latitude: 33.0, longitude: 139.5, number: 1, type: "japan",
       expected_x: NilClass, expected_y: NilClass, expected_m: Float},
      {latitude: 33.0, longitude: 129.5, number: 0, type: "japan",
       expected_x: NilClass, expected_y: NilClass, expected_m: NilClass}
    ]
    checker.each do |c|
      r = gtoc(latitude: c[:latitude],
               longitude: c[:longitude],
               number: c[:number],
               type: c[:type])
      assert_equal(c[:expected_x], r[:x].class)
      assert_equal(c[:expected_y], r[:y].class)
      assert_equal(c[:expected_m], r[:m].class)
    end
  end
end
