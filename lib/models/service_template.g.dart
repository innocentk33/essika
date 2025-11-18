// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_template.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetServiceTemplateCollection on Isar {
  IsarCollection<ServiceTemplate> get serviceTemplates => this.collection();
}

const ServiceTemplateSchema = CollectionSchema(
  name: r'ServiceTemplate',
  id: 4381736425458434054,
  properties: {
    r'category': PropertySchema(
      id: 0,
      name: r'category',
      type: IsarType.string,
    ),
    r'isPopular': PropertySchema(
      id: 1,
      name: r'isPopular',
      type: IsarType.bool,
    ),
    r'logoUrl': PropertySchema(id: 2, name: r'logoUrl', type: IsarType.string),
    r'name': PropertySchema(id: 3, name: r'name', type: IsarType.string),
    r'suggestedCycle': PropertySchema(
      id: 4,
      name: r'suggestedCycle',
      type: IsarType.byte,
      enumMap: _ServiceTemplatesuggestedCycleEnumValueMap,
    ),
    r'suggestedPrice': PropertySchema(
      id: 5,
      name: r'suggestedPrice',
      type: IsarType.double,
    ),
  },

  estimateSize: _serviceTemplateEstimateSize,
  serialize: _serviceTemplateSerialize,
  deserialize: _serviceTemplateDeserialize,
  deserializeProp: _serviceTemplateDeserializeProp,
  idName: r'id',
  indexes: {
    r'name': IndexSchema(
      id: 879695947855722453,
      name: r'name',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'name',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _serviceTemplateGetId,
  getLinks: _serviceTemplateGetLinks,
  attach: _serviceTemplateAttach,
  version: '3.3.0',
);

int _serviceTemplateEstimateSize(
  ServiceTemplate object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.category;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.logoUrl;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.name.length * 3;
  return bytesCount;
}

void _serviceTemplateSerialize(
  ServiceTemplate object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.category);
  writer.writeBool(offsets[1], object.isPopular);
  writer.writeString(offsets[2], object.logoUrl);
  writer.writeString(offsets[3], object.name);
  writer.writeByte(offsets[4], object.suggestedCycle.index);
  writer.writeDouble(offsets[5], object.suggestedPrice);
}

ServiceTemplate _serviceTemplateDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ServiceTemplate(
    category: reader.readStringOrNull(offsets[0]),
    isPopular: reader.readBoolOrNull(offsets[1]) ?? false,
    logoUrl: reader.readStringOrNull(offsets[2]),
    name: reader.readStringOrNull(offsets[3]) ?? '',
    suggestedCycle:
        _ServiceTemplatesuggestedCycleValueEnumMap[reader.readByteOrNull(
          offsets[4],
        )] ??
        BillingCycle.monthly,
    suggestedPrice: reader.readDoubleOrNull(offsets[5]),
  );
  object.id = id;
  return object;
}

P _serviceTemplateDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 4:
      return (_ServiceTemplatesuggestedCycleValueEnumMap[reader.readByteOrNull(
                offset,
              )] ??
              BillingCycle.monthly)
          as P;
    case 5:
      return (reader.readDoubleOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _ServiceTemplatesuggestedCycleEnumValueMap = {'monthly': 0, 'yearly': 1};
const _ServiceTemplatesuggestedCycleValueEnumMap = {
  0: BillingCycle.monthly,
  1: BillingCycle.yearly,
};

Id _serviceTemplateGetId(ServiceTemplate object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _serviceTemplateGetLinks(ServiceTemplate object) {
  return [];
}

void _serviceTemplateAttach(
  IsarCollection<dynamic> col,
  Id id,
  ServiceTemplate object,
) {
  object.id = id;
}

extension ServiceTemplateByIndex on IsarCollection<ServiceTemplate> {
  Future<ServiceTemplate?> getByName(String name) {
    return getByIndex(r'name', [name]);
  }

  ServiceTemplate? getByNameSync(String name) {
    return getByIndexSync(r'name', [name]);
  }

  Future<bool> deleteByName(String name) {
    return deleteByIndex(r'name', [name]);
  }

  bool deleteByNameSync(String name) {
    return deleteByIndexSync(r'name', [name]);
  }

  Future<List<ServiceTemplate?>> getAllByName(List<String> nameValues) {
    final values = nameValues.map((e) => [e]).toList();
    return getAllByIndex(r'name', values);
  }

  List<ServiceTemplate?> getAllByNameSync(List<String> nameValues) {
    final values = nameValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'name', values);
  }

  Future<int> deleteAllByName(List<String> nameValues) {
    final values = nameValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'name', values);
  }

  int deleteAllByNameSync(List<String> nameValues) {
    final values = nameValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'name', values);
  }

  Future<Id> putByName(ServiceTemplate object) {
    return putByIndex(r'name', object);
  }

  Id putByNameSync(ServiceTemplate object, {bool saveLinks = true}) {
    return putByIndexSync(r'name', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByName(List<ServiceTemplate> objects) {
    return putAllByIndex(r'name', objects);
  }

  List<Id> putAllByNameSync(
    List<ServiceTemplate> objects, {
    bool saveLinks = true,
  }) {
    return putAllByIndexSync(r'name', objects, saveLinks: saveLinks);
  }
}

extension ServiceTemplateQueryWhereSort
    on QueryBuilder<ServiceTemplate, ServiceTemplate, QWhere> {
  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ServiceTemplateQueryWhere
    on QueryBuilder<ServiceTemplate, ServiceTemplate, QWhereClause> {
  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterWhereClause> idEqualTo(
    Id id,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterWhereClause>
  idNotEqualTo(Id id) {
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

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterWhereClause>
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterWhereClause> idBetween(
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

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterWhereClause> nameEqualTo(
    String name,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'name', value: [name]),
      );
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterWhereClause>
  nameNotEqualTo(String name) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'name',
                lower: [],
                upper: [name],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'name',
                lower: [name],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'name',
                lower: [name],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'name',
                lower: [],
                upper: [name],
                includeUpper: false,
              ),
            );
      }
    });
  }
}

extension ServiceTemplateQueryFilter
    on QueryBuilder<ServiceTemplate, ServiceTemplate, QFilterCondition> {
  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterFilterCondition>
  categoryIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'category'),
      );
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterFilterCondition>
  categoryIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'category'),
      );
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterFilterCondition>
  categoryEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'category',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterFilterCondition>
  categoryGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'category',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterFilterCondition>
  categoryLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'category',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterFilterCondition>
  categoryBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'category',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterFilterCondition>
  categoryStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'category',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterFilterCondition>
  categoryEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'category',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterFilterCondition>
  categoryContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'category',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterFilterCondition>
  categoryMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'category',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterFilterCondition>
  categoryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'category', value: ''),
      );
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterFilterCondition>
  categoryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'category', value: ''),
      );
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterFilterCondition>
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterFilterCondition>
  idGreaterThan(Id value, {bool include = false}) {
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

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterFilterCondition>
  idLessThan(Id value, {bool include = false}) {
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

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterFilterCondition>
  idBetween(
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

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterFilterCondition>
  isPopularEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isPopular', value: value),
      );
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterFilterCondition>
  logoUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'logoUrl'),
      );
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterFilterCondition>
  logoUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'logoUrl'),
      );
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterFilterCondition>
  logoUrlEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'logoUrl',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterFilterCondition>
  logoUrlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'logoUrl',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterFilterCondition>
  logoUrlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'logoUrl',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterFilterCondition>
  logoUrlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'logoUrl',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterFilterCondition>
  logoUrlStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'logoUrl',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterFilterCondition>
  logoUrlEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'logoUrl',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterFilterCondition>
  logoUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'logoUrl',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterFilterCondition>
  logoUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'logoUrl',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterFilterCondition>
  logoUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'logoUrl', value: ''),
      );
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterFilterCondition>
  logoUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'logoUrl', value: ''),
      );
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterFilterCondition>
  nameEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterFilterCondition>
  nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterFilterCondition>
  nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterFilterCondition>
  nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'name',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterFilterCondition>
  nameStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterFilterCondition>
  nameEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterFilterCondition>
  nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterFilterCondition>
  nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'name',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterFilterCondition>
  nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'name', value: ''),
      );
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterFilterCondition>
  nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'name', value: ''),
      );
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterFilterCondition>
  suggestedCycleEqualTo(BillingCycle value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'suggestedCycle', value: value),
      );
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterFilterCondition>
  suggestedCycleGreaterThan(BillingCycle value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'suggestedCycle',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterFilterCondition>
  suggestedCycleLessThan(BillingCycle value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'suggestedCycle',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterFilterCondition>
  suggestedCycleBetween(
    BillingCycle lower,
    BillingCycle upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'suggestedCycle',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterFilterCondition>
  suggestedPriceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'suggestedPrice'),
      );
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterFilterCondition>
  suggestedPriceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'suggestedPrice'),
      );
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterFilterCondition>
  suggestedPriceEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'suggestedPrice',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterFilterCondition>
  suggestedPriceGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'suggestedPrice',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterFilterCondition>
  suggestedPriceLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'suggestedPrice',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterFilterCondition>
  suggestedPriceBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'suggestedPrice',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }
}

extension ServiceTemplateQueryObject
    on QueryBuilder<ServiceTemplate, ServiceTemplate, QFilterCondition> {}

extension ServiceTemplateQueryLinks
    on QueryBuilder<ServiceTemplate, ServiceTemplate, QFilterCondition> {}

extension ServiceTemplateQuerySortBy
    on QueryBuilder<ServiceTemplate, ServiceTemplate, QSortBy> {
  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterSortBy>
  sortByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterSortBy>
  sortByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterSortBy>
  sortByIsPopular() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPopular', Sort.asc);
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterSortBy>
  sortByIsPopularDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPopular', Sort.desc);
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterSortBy> sortByLogoUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logoUrl', Sort.asc);
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterSortBy>
  sortByLogoUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logoUrl', Sort.desc);
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterSortBy>
  sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterSortBy>
  sortBySuggestedCycle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'suggestedCycle', Sort.asc);
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterSortBy>
  sortBySuggestedCycleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'suggestedCycle', Sort.desc);
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterSortBy>
  sortBySuggestedPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'suggestedPrice', Sort.asc);
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterSortBy>
  sortBySuggestedPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'suggestedPrice', Sort.desc);
    });
  }
}

extension ServiceTemplateQuerySortThenBy
    on QueryBuilder<ServiceTemplate, ServiceTemplate, QSortThenBy> {
  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterSortBy>
  thenByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterSortBy>
  thenByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterSortBy>
  thenByIsPopular() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPopular', Sort.asc);
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterSortBy>
  thenByIsPopularDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPopular', Sort.desc);
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterSortBy> thenByLogoUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logoUrl', Sort.asc);
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterSortBy>
  thenByLogoUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logoUrl', Sort.desc);
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterSortBy>
  thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterSortBy>
  thenBySuggestedCycle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'suggestedCycle', Sort.asc);
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterSortBy>
  thenBySuggestedCycleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'suggestedCycle', Sort.desc);
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterSortBy>
  thenBySuggestedPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'suggestedPrice', Sort.asc);
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QAfterSortBy>
  thenBySuggestedPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'suggestedPrice', Sort.desc);
    });
  }
}

extension ServiceTemplateQueryWhereDistinct
    on QueryBuilder<ServiceTemplate, ServiceTemplate, QDistinct> {
  QueryBuilder<ServiceTemplate, ServiceTemplate, QDistinct> distinctByCategory({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'category', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QDistinct>
  distinctByIsPopular() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isPopular');
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QDistinct> distinctByLogoUrl({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'logoUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QDistinct> distinctByName({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QDistinct>
  distinctBySuggestedCycle() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'suggestedCycle');
    });
  }

  QueryBuilder<ServiceTemplate, ServiceTemplate, QDistinct>
  distinctBySuggestedPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'suggestedPrice');
    });
  }
}

extension ServiceTemplateQueryProperty
    on QueryBuilder<ServiceTemplate, ServiceTemplate, QQueryProperty> {
  QueryBuilder<ServiceTemplate, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ServiceTemplate, String?, QQueryOperations> categoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'category');
    });
  }

  QueryBuilder<ServiceTemplate, bool, QQueryOperations> isPopularProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isPopular');
    });
  }

  QueryBuilder<ServiceTemplate, String?, QQueryOperations> logoUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'logoUrl');
    });
  }

  QueryBuilder<ServiceTemplate, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<ServiceTemplate, BillingCycle, QQueryOperations>
  suggestedCycleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'suggestedCycle');
    });
  }

  QueryBuilder<ServiceTemplate, double?, QQueryOperations>
  suggestedPriceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'suggestedPrice');
    });
  }
}
