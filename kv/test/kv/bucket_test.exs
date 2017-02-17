defmodule KV.BucketTest do
  use ExUnit.Case, async: true # uses multiple cores

  # setup callback, runs before every test
  setup do
    {:ok, bucket} = KV.Bucket.start_link
    {:ok, bucket: bucket}
  end

  test "stores values by key", %{bucket: bucket} do
    assert KV.Bucket.get(bucket, "milk") == nil

    KV.Bucket.put(bucket, "milk", 3)
    assert KV.Bucket.get(bucket, "milk") == 3
  end

  test "removes value by key", %{bucket: bucket} do
    KV.Bucket.put(bucket, "eggs", 2)
    assert KV.Bucket.get(bucket, "eggs") == 2

    KV.Bucket.delete(bucket, "eggs")
    assert KV.Bucket.get(bucket, "eggs") == nil
  end
end
