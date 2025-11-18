// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'renewal_event.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetRenewalEventCollection on Isar {
  IsarCollection<RenewalEvent> get renewalEvents => this.collection();
}

const RenewalEventSchema = CollectionSchema(
  name: r'RenewalEvent',
  id: 7727958052186489486,
  properties: {
    r'amount': PropertySchema(id: 0, name: r'amount', type: IsarType.double),
    r'month': PropertySchema(id: 1, name: r'month', type: IsarType.long),
    r'renewalDate': PropertySchema(
      id: 2,
      name: r'renewalDate',
      type: IsarType.dateTime,
    ),
    r'subscriptionId': PropertySchema(
      id: 3,
      name: r'subscriptionId',
      type: IsarType.long,
    ),
    r'year': PropertySchema(id: 4, name: r'year', type: IsarType.long),
  },

  estimateSize: _renewalEventEstimateSize,
  serialize: _renewalEventSerialize,
  deserialize: _renewalEventDeserialize,
  deserializeProp: _renewalEventDeserializeProp,
  idName: r'id',
  indexes: {
    r'subscriptionId': IndexSchema(
      id: -2440251475652077983,
      name: r'subscriptionId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'subscriptionId',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
    r'renewalDate': IndexSchema(
      id: 4609864393096219240,
      name: r'renewalDate',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'renewalDate',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
    r'year_month': IndexSchema(
      id: -3509244304425196138,
      name: r'year_month',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'year',
          type: IndexType.value,
          caseSensitive: false,
        ),
        IndexPropertySchema(
          name: r'month',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _renewalEventGetId,
  getLinks: _renewalEventGetLinks,
  attach: _renewalEventAttach,
  version: '3.3.0',
);

int _renewalEventEstimateSize(
  RenewalEvent object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _renewalEventSerialize(
  RenewalEvent object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.amount);
  writer.writeLong(offsets[1], object.month);
  writer.writeDateTime(offsets[2], object.renewalDate);
  writer.writeLong(offsets[3], object.subscriptionId);
  writer.writeLong(offsets[4], object.year);
}

RenewalEvent _renewalEventDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RenewalEvent();
  object.amount = reader.readDouble(offsets[0]);
  object.id = id;
  object.month = reader.readLong(offsets[1]);
  object.renewalDate = reader.readDateTime(offsets[2]);
  object.subscriptionId = reader.readLong(offsets[3]);
  object.year = reader.readLong(offsets[4]);
  return object;
}

P _renewalEventDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _renewalEventGetId(RenewalEvent object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _renewalEventGetLinks(RenewalEvent object) {
  return [];
}

void _renewalEventAttach(
  IsarCollection<dynamic> col,
  Id id,
  RenewalEvent object,
) {
  object.id = id;
}

extension RenewalEventQueryWhereSort
    on QueryBuilder<RenewalEvent, RenewalEvent, QWhere> {
  QueryBuilder<RenewalEvent, RenewalEvent, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QAfterWhere> anySubscriptionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'subscriptionId'),
      );
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QAfterWhere> anyRenewalDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'renewalDate'),
      );
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QAfterWhere> anyYearMonth() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'year_month'),
      );
    });
  }
}

extension RenewalEventQueryWhere
    on QueryBuilder<RenewalEvent, RenewalEvent, QWhereClause> {
  QueryBuilder<RenewalEvent, RenewalEvent, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QAfterWhereClause> idNotEqualTo(
    Id id,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QAfterWhereClause>
  subscriptionIdEqualTo(int subscriptionId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(
          indexName: r'subscriptionId',
          value: [subscriptionId],
        ),
      );
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QAfterWhereClause>
  subscriptionIdNotEqualTo(int subscriptionId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'subscriptionId',
                lower: [],
                upper: [subscriptionId],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'subscriptionId',
                lower: [subscriptionId],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'subscriptionId',
                lower: [subscriptionId],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'subscriptionId',
                lower: [],
                upper: [subscriptionId],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QAfterWhereClause>
  subscriptionIdGreaterThan(int subscriptionId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'subscriptionId',
          lower: [subscriptionId],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QAfterWhereClause>
  subscriptionIdLessThan(int subscriptionId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'subscriptionId',
          lower: [],
          upper: [subscriptionId],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QAfterWhereClause>
  subscriptionIdBetween(
    int lowerSubscriptionId,
    int upperSubscriptionId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'subscriptionId',
          lower: [lowerSubscriptionId],
          includeLower: includeLower,
          upper: [upperSubscriptionId],
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QAfterWhereClause>
  renewalDateEqualTo(DateTime renewalDate) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(
          indexName: r'renewalDate',
          value: [renewalDate],
        ),
      );
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QAfterWhereClause>
  renewalDateNotEqualTo(DateTime renewalDate) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'renewalDate',
                lower: [],
                upper: [renewalDate],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'renewalDate',
                lower: [renewalDate],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'renewalDate',
                lower: [renewalDate],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'renewalDate',
                lower: [],
                upper: [renewalDate],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QAfterWhereClause>
  renewalDateGreaterThan(DateTime renewalDate, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'renewalDate',
          lower: [renewalDate],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QAfterWhereClause>
  renewalDateLessThan(DateTime renewalDate, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'renewalDate',
          lower: [],
          upper: [renewalDate],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QAfterWhereClause>
  renewalDateBetween(
    DateTime lowerRenewalDate,
    DateTime upperRenewalDate, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'renewalDate',
          lower: [lowerRenewalDate],
          includeLower: includeLower,
          upper: [upperRenewalDate],
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QAfterWhereClause>
  yearEqualToAnyMonth(int year) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'year_month', value: [year]),
      );
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QAfterWhereClause>
  yearNotEqualToAnyMonth(int year) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'year_month',
                lower: [],
                upper: [year],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'year_month',
                lower: [year],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'year_month',
                lower: [year],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'year_month',
                lower: [],
                upper: [year],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QAfterWhereClause>
  yearGreaterThanAnyMonth(int year, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'year_month',
          lower: [year],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QAfterWhereClause>
  yearLessThanAnyMonth(int year, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'year_month',
          lower: [],
          upper: [year],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QAfterWhereClause>
  yearBetweenAnyMonth(
    int lowerYear,
    int upperYear, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'year_month',
          lower: [lowerYear],
          includeLower: includeLower,
          upper: [upperYear],
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QAfterWhereClause> yearMonthEqualTo(
    int year,
    int month,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(
          indexName: r'year_month',
          value: [year, month],
        ),
      );
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QAfterWhereClause>
  yearEqualToMonthNotEqualTo(int year, int month) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'year_month',
                lower: [year],
                upper: [year, month],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'year_month',
                lower: [year, month],
                includeLower: false,
                upper: [year],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'year_month',
                lower: [year, month],
                includeLower: false,
                upper: [year],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'year_month',
                lower: [year],
                upper: [year, month],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QAfterWhereClause>
  yearEqualToMonthGreaterThan(int year, int month, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'year_month',
          lower: [year, month],
          includeLower: include,
          upper: [year],
        ),
      );
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QAfterWhereClause>
  yearEqualToMonthLessThan(int year, int month, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'year_month',
          lower: [year],
          upper: [year, month],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QAfterWhereClause>
  yearEqualToMonthBetween(
    int year,
    int lowerMonth,
    int upperMonth, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'year_month',
          lower: [year, lowerMonth],
          includeLower: includeLower,
          upper: [year, upperMonth],
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension RenewalEventQueryFilter
    on QueryBuilder<RenewalEvent, RenewalEvent, QFilterCondition> {
  QueryBuilder<RenewalEvent, RenewalEvent, QAfterFilterCondition> amountEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'amount',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QAfterFilterCondition>
  amountGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'amount',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QAfterFilterCondition>
  amountLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'amount',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QAfterFilterCondition> amountBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'amount',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QAfterFilterCondition> monthEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'month', value: value),
      );
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QAfterFilterCondition>
  monthGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'month',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QAfterFilterCondition> monthLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'month',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QAfterFilterCondition> monthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'month',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QAfterFilterCondition>
  renewalDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'renewalDate', value: value),
      );
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QAfterFilterCondition>
  renewalDateGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'renewalDate',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QAfterFilterCondition>
  renewalDateLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'renewalDate',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QAfterFilterCondition>
  renewalDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'renewalDate',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QAfterFilterCondition>
  subscriptionIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'subscriptionId', value: value),
      );
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QAfterFilterCondition>
  subscriptionIdGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'subscriptionId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QAfterFilterCondition>
  subscriptionIdLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'subscriptionId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QAfterFilterCondition>
  subscriptionIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'subscriptionId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QAfterFilterCondition> yearEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'year', value: value),
      );
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QAfterFilterCondition>
  yearGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'year',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QAfterFilterCondition> yearLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'year',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QAfterFilterCondition> yearBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'year',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension RenewalEventQueryObject
    on QueryBuilder<RenewalEvent, RenewalEvent, QFilterCondition> {}

extension RenewalEventQueryLinks
    on QueryBuilder<RenewalEvent, RenewalEvent, QFilterCondition> {}

extension RenewalEventQuerySortBy
    on QueryBuilder<RenewalEvent, RenewalEvent, QSortBy> {
  QueryBuilder<RenewalEvent, RenewalEvent, QAfterSortBy> sortByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.asc);
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QAfterSortBy> sortByAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.desc);
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QAfterSortBy> sortByMonth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'month', Sort.asc);
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QAfterSortBy> sortByMonthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'month', Sort.desc);
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QAfterSortBy> sortByRenewalDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'renewalDate', Sort.asc);
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QAfterSortBy>
  sortByRenewalDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'renewalDate', Sort.desc);
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QAfterSortBy>
  sortBySubscriptionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subscriptionId', Sort.asc);
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QAfterSortBy>
  sortBySubscriptionIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subscriptionId', Sort.desc);
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QAfterSortBy> sortByYear() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'year', Sort.asc);
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QAfterSortBy> sortByYearDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'year', Sort.desc);
    });
  }
}

extension RenewalEventQuerySortThenBy
    on QueryBuilder<RenewalEvent, RenewalEvent, QSortThenBy> {
  QueryBuilder<RenewalEvent, RenewalEvent, QAfterSortBy> thenByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.asc);
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QAfterSortBy> thenByAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.desc);
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QAfterSortBy> thenByMonth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'month', Sort.asc);
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QAfterSortBy> thenByMonthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'month', Sort.desc);
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QAfterSortBy> thenByRenewalDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'renewalDate', Sort.asc);
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QAfterSortBy>
  thenByRenewalDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'renewalDate', Sort.desc);
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QAfterSortBy>
  thenBySubscriptionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subscriptionId', Sort.asc);
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QAfterSortBy>
  thenBySubscriptionIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subscriptionId', Sort.desc);
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QAfterSortBy> thenByYear() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'year', Sort.asc);
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QAfterSortBy> thenByYearDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'year', Sort.desc);
    });
  }
}

extension RenewalEventQueryWhereDistinct
    on QueryBuilder<RenewalEvent, RenewalEvent, QDistinct> {
  QueryBuilder<RenewalEvent, RenewalEvent, QDistinct> distinctByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'amount');
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QDistinct> distinctByMonth() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'month');
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QDistinct> distinctByRenewalDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'renewalDate');
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QDistinct>
  distinctBySubscriptionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'subscriptionId');
    });
  }

  QueryBuilder<RenewalEvent, RenewalEvent, QDistinct> distinctByYear() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'year');
    });
  }
}

extension RenewalEventQueryProperty
    on QueryBuilder<RenewalEvent, RenewalEvent, QQueryProperty> {
  QueryBuilder<RenewalEvent, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<RenewalEvent, double, QQueryOperations> amountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'amount');
    });
  }

  QueryBuilder<RenewalEvent, int, QQueryOperations> monthProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'month');
    });
  }

  QueryBuilder<RenewalEvent, DateTime, QQueryOperations> renewalDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'renewalDate');
    });
  }

  QueryBuilder<RenewalEvent, int, QQueryOperations> subscriptionIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'subscriptionId');
    });
  }

  QueryBuilder<RenewalEvent, int, QQueryOperations> yearProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'year');
    });
  }
}
