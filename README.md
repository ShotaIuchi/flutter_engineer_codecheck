# flutter_engineer_codecheck

## メモ

### Lint

- チェック

```
$ flutter analyze
```

- 修正

```
$ dart fix --apply
```

### Test

- 全部

```
$ cd <プロジェクトルート>
$ ./run_test.sh
```

- unit / widget

```
$ flutter test
```

- integration

```
$ cd <プロジェクトルート>
$ cd test_integration
$ ./run.sh
```

## 留意

- Lint 利用ライブラリ

  - very_good_analysis 利用

- Test 種別

  - unit
  - widget
  - integration

- GitHub Action 対応

  - cache
  - android build
  - deploy (firebase app distribution)
  - lint
  - unit/widget test

- GitHub Action 非対応

  - ios build
  - integration test
