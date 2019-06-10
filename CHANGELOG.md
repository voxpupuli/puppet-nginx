# Changelog

All notable changes to this project will be documented in this file.
Each new release typically also includes the latest modulesync defaults.
These should not affect the functionality of the module.

## [v1.0.0](https://github.com/voxpupuli/puppet-nginx/tree/v1.0.0) (2019-06-10)

[Full Changelog](https://github.com/voxpupuli/puppet-nginx/compare/v0.16.0...v1.0.0)

**Breaking changes:**

- Replace `add\_listen\_directive` with `nginx\_version` [\#1330](https://github.com/voxpupuli/puppet-nginx/pull/1330) ([alexjfisher](https://github.com/alexjfisher))

**Implemented enhancements:**

- Add rewrite\_non\_www\_to\_www option [\#1326](https://github.com/voxpupuli/puppet-nginx/pull/1326) ([simmerz](https://github.com/simmerz))

**Fixed bugs:**

- Allow puppetlabs/concat 6.x [\#1334](https://github.com/voxpupuli/puppet-nginx/pull/1334) ([dhoppe](https://github.com/dhoppe))

**Closed issues:**

- Support for Ubuntu 18.04? [\#1307](https://github.com/voxpupuli/puppet-nginx/issues/1307)

**Merged pull requests:**

- fixing some documentation for setting up UDP streams [\#1333](https://github.com/voxpupuli/puppet-nginx/pull/1333) ([martinrw](https://github.com/martinrw))
- Allow `puppetlabs/stdlib` 6.x [\#1329](https://github.com/voxpupuli/puppet-nginx/pull/1329) ([alexjfisher](https://github.com/alexjfisher))
- Modulesync 2.6.1 with local changes [\#1323](https://github.com/voxpupuli/puppet-nginx/pull/1323) ([ekohl](https://github.com/ekohl))
- Fix port typo in example [\#1322](https://github.com/voxpupuli/puppet-nginx/pull/1322) ([dkess](https://github.com/dkess))
- Allow setting a custom path for mime.types [\#1321](https://github.com/voxpupuli/puppet-nginx/pull/1321) ([jacksgt](https://github.com/jacksgt))
- add ubuntu1804 as supported OS [\#1319](https://github.com/voxpupuli/puppet-nginx/pull/1319) ([Dan33l](https://github.com/Dan33l))
- Fix `upstream\_context` parameter in README [\#1317](https://github.com/voxpupuli/puppet-nginx/pull/1317) ([alexjfisher](https://github.com/alexjfisher))
- Fixed variable name and code style [\#1314](https://github.com/voxpupuli/puppet-nginx/pull/1314) ([aleksmark](https://github.com/aleksmark))

## [v0.16.0](https://github.com/voxpupuli/puppet-nginx/tree/v0.16.0) (2019-02-09)

[Full Changelog](https://github.com/voxpupuli/puppet-nginx/compare/v0.15.0...v0.16.0)

**Breaking changes:**

- modulesync 2.5.1 and drop Puppet 4 [\#1308](https://github.com/voxpupuli/puppet-nginx/pull/1308) ([bastelfreak](https://github.com/bastelfreak))
- Add hiera defaults configuration options for all resources; rename $nginx\_upstream\_defaults to $nginx\_upstreams\_defaults [\#1080](https://github.com/voxpupuli/puppet-nginx/pull/1080) ([mvisonneau](https://github.com/mvisonneau))

**Implemented enhancements:**

- Feature\_request: Add proxy\_max\_temp\_file\_size and proxy\_busy\_buffers\_size to parameter list [\#1176](https://github.com/voxpupuli/puppet-nginx/issues/1176)
- Feature request: assign nginx location to multiple servers [\#1135](https://github.com/voxpupuli/puppet-nginx/issues/1135)
- Same location on multiple vhosts [\#644](https://github.com/voxpupuli/puppet-nginx/issues/644)
- add repo\_source for custom Debian repo [\#1298](https://github.com/voxpupuli/puppet-nginx/pull/1298) ([elfranne](https://github.com/elfranne))
- Automatically require SSL cert files in the server [\#1296](https://github.com/voxpupuli/puppet-nginx/pull/1296) ([ekohl](https://github.com/ekohl))
- Update smartos support [\#1290](https://github.com/voxpupuli/puppet-nginx/pull/1290) ([joelgarboden](https://github.com/joelgarboden))
- Allow multiple servers per location [\#1278](https://github.com/voxpupuli/puppet-nginx/pull/1278) ([SaschaDoering](https://github.com/SaschaDoering))
- Add autoindex to ssl\_header too [\#1275](https://github.com/voxpupuli/puppet-nginx/pull/1275) ([bc-bjoern](https://github.com/bc-bjoern))
- allow adding custom mime types while still using the module defaults [\#1268](https://github.com/voxpupuli/puppet-nginx/pull/1268) ([bryangwilliam](https://github.com/bryangwilliam))
- Introduce two new optional proxy parameters [\#1256](https://github.com/voxpupuli/puppet-nginx/pull/1256) ([ruriky](https://github.com/ruriky))
- initial support for snippets [\#1231](https://github.com/voxpupuli/puppet-nginx/pull/1231) ([bryangwilliam](https://github.com/bryangwilliam))

**Fixed bugs:**

- overwrite FreeBSD and DragonFlyBSD log\_user [\#1312](https://github.com/voxpupuli/puppet-nginx/pull/1312) ([olevole](https://github.com/olevole))
- Fix `$nginx\_upstreams\_defaults` type [\#1309](https://github.com/voxpupuli/puppet-nginx/pull/1309) ([saz](https://github.com/saz))
- enable ensure switch on streams-available/\* files [\#1306](https://github.com/voxpupuli/puppet-nginx/pull/1306) ([aleksmark](https://github.com/aleksmark))
- Fix IPv6 adresses in upstream members [\#1300](https://github.com/voxpupuli/puppet-nginx/pull/1300) ([silkeh](https://github.com/silkeh))
- dont deploy "ssl on" on nginx 1.15 or newer \(for mailhost\) [\#1281](https://github.com/voxpupuli/puppet-nginx/pull/1281) ([rhykw](https://github.com/rhykw))
- update location of passenger repo gpgkey [\#1277](https://github.com/voxpupuli/puppet-nginx/pull/1277) ([pauljflo](https://github.com/pauljflo))
- Fix the condition for upstream members [\#1276](https://github.com/voxpupuli/puppet-nginx/pull/1276) ([SaschaDoering](https://github.com/SaschaDoering))

**Closed issues:**

- Streamhost resource does not remove the file [\#1304](https://github.com/voxpupuli/puppet-nginx/issues/1304)
- IPv6 upstream members produce invalid configuration [\#1299](https://github.com/voxpupuli/puppet-nginx/issues/1299)
- Is there a way to only create an entry if the cert exists? [\#1295](https://github.com/voxpupuli/puppet-nginx/issues/1295)
- \[warn\] the "ssl" directive is deprecated, use the "listen ... ssl" directive instead \(mailhost\) [\#1284](https://github.com/voxpupuli/puppet-nginx/issues/1284)
- Error pages on location level \[help\] [\#1279](https://github.com/voxpupuli/puppet-nginx/issues/1279)
-  "location" directive is not allowed here in /etc/nginx/sites-enabled/example.mydomain.com.conf:2 [\#1271](https://github.com/voxpupuli/puppet-nginx/issues/1271)
- Nginx::Resource::Server: has no parameter named 'proxy\_send\_timeout' [\#1186](https://github.com/voxpupuli/puppet-nginx/issues/1186)

**Merged pull requests:**

- simplify travis helper [\#1311](https://github.com/voxpupuli/puppet-nginx/pull/1311) ([bastelfreak](https://github.com/bastelfreak))
- Param server might also be a default upstream param [\#1310](https://github.com/voxpupuli/puppet-nginx/pull/1310) ([saz](https://github.com/saz))
- change rights for sites-enabled, streams-available [\#1289](https://github.com/voxpupuli/puppet-nginx/pull/1289) ([danwerspb](https://github.com/danwerspb))
- Update documentation and examples associated with adding upstream parameters [\#1273](https://github.com/voxpupuli/puppet-nginx/pull/1273) ([alexskr](https://github.com/alexskr))

## [v0.15.0](https://github.com/voxpupuli/puppet-nginx/tree/v0.15.0) (2018-10-20)

[Full Changelog](https://github.com/voxpupuli/puppet-nginx/compare/v0.14.0...v0.15.0)

**Breaking changes:**

- Change gzip default to off and update tests [\#1266](https://github.com/voxpupuli/puppet-nginx/pull/1266) ([willrigling](https://github.com/willrigling))
- Add parameters to upstream and upstreammembers [\#1233](https://github.com/voxpupuli/puppet-nginx/pull/1233) ([SaschaDoering](https://github.com/SaschaDoering))

**Implemented enhancements:**

- gzip is enabled by default [\#1085](https://github.com/voxpupuli/puppet-nginx/issues/1085)
- Allow setting unquoted or custom flags on add\_headers [\#1249](https://github.com/voxpupuli/puppet-nginx/pull/1249) ([itbm](https://github.com/itbm))

**Closed issues:**

- introduction of $log\_user broke module on OpenBSD [\#1259](https://github.com/voxpupuli/puppet-nginx/issues/1259)
- nginx::resource::upstream make consistent use of nginx::resource::upstream::member [\#1222](https://github.com/voxpupuli/puppet-nginx/issues/1222)

**Merged pull requests:**

- add default values for AIX servers [\#1263](https://github.com/voxpupuli/puppet-nginx/pull/1263) ([feltra](https://github.com/feltra))
- Improve example of quick install in README [\#1262](https://github.com/voxpupuli/puppet-nginx/pull/1262) ([natemccurdy](https://github.com/natemccurdy))
- Archlinux: Set default log user to http [\#1261](https://github.com/voxpupuli/puppet-nginx/pull/1261) ([mauricemeyer](https://github.com/mauricemeyer))
- add the log\_user with proper value to OpenBSD override section. [\#1260](https://github.com/voxpupuli/puppet-nginx/pull/1260) ([buzzdeee](https://github.com/buzzdeee))

## [v0.14.0](https://github.com/voxpupuli/puppet-nginx/tree/v0.14.0) (2018-10-06)

[Full Changelog](https://github.com/voxpupuli/puppet-nginx/compare/v0.13.0...v0.14.0)

**Implemented enhancements:**

- Move error\_log to the http section [\#1253](https://github.com/voxpupuli/puppet-nginx/pull/1253) ([ekohl](https://github.com/ekohl))
- Strip line endings in mime.types [\#1252](https://github.com/voxpupuli/puppet-nginx/pull/1252) ([ekohl](https://github.com/ekohl))
- Propery handle ${client\_body,proxy}\_temp\_path [\#1251](https://github.com/voxpupuli/puppet-nginx/pull/1251) ([ekohl](https://github.com/ekohl))
- Add mime.types file template and default values for it [\#1243](https://github.com/voxpupuli/puppet-nginx/pull/1243) ([martialblog](https://github.com/martialblog))
- start one worker process per core [\#1238](https://github.com/voxpupuli/puppet-nginx/pull/1238) ([bastelfreak](https://github.com/bastelfreak))

**Fixed bugs:**

- Fix logging setup on Debian [\#1254](https://github.com/voxpupuli/puppet-nginx/pull/1254) ([ekohl](https://github.com/ekohl))

**Closed issues:**

- Reliance on mime.types [\#1240](https://github.com/voxpupuli/puppet-nginx/issues/1240)
- Multiple Location Problem [\#1221](https://github.com/voxpupuli/puppet-nginx/issues/1221)

**Merged pull requests:**

- modulesync 2.1.0 and  allow puppet 6.x [\#1257](https://github.com/voxpupuli/puppet-nginx/pull/1257) ([bastelfreak](https://github.com/bastelfreak))
- Use more Puppet 4 types [\#1255](https://github.com/voxpupuli/puppet-nginx/pull/1255) ([ekohl](https://github.com/ekohl))
- fix typo in resource/server.pp [\#1248](https://github.com/voxpupuli/puppet-nginx/pull/1248) ([kpankonen](https://github.com/kpankonen))
- get rid of topscope variables [\#1237](https://github.com/voxpupuli/puppet-nginx/pull/1237) ([bastelfreak](https://github.com/bastelfreak))
- Use HTTPS for Yum repositories [\#1236](https://github.com/voxpupuli/puppet-nginx/pull/1236) ([mhutter](https://github.com/mhutter))
- purge duplicate CHANGELOG.md footer [\#1229](https://github.com/voxpupuli/puppet-nginx/pull/1229) ([bastelfreak](https://github.com/bastelfreak))

## [v0.13.0](https://github.com/voxpupuli/puppet-nginx/tree/v0.13.0) (2018-07-09)

[Full Changelog](https://github.com/voxpupuli/puppet-nginx/compare/v0.12.0...v0.13.0)

**Implemented enhancements:**

- nginx::service::service\_enable does not exist [\#1208](https://github.com/voxpupuli/puppet-nginx/issues/1208)
- add absolute\_redirect support [\#1228](https://github.com/voxpupuli/puppet-nginx/pull/1228) ([bryangwilliam](https://github.com/bryangwilliam))
- Add service\_enable and simplify service\_ensure, \#1208 [\#1217](https://github.com/voxpupuli/puppet-nginx/pull/1217) ([fnoop](https://github.com/fnoop))
- Add support for dynamic modules. [\#1180](https://github.com/voxpupuli/puppet-nginx/pull/1180) ([sevencastles](https://github.com/sevencastles))

**Fixed bugs:**

- \[warn\] the "ssl" directive is deprecated, use the "listen ... ssl" directive instead [\#1224](https://github.com/voxpupuli/puppet-nginx/issues/1224)
- dont deploy "ssl on" on nginx 1.15 or newer [\#1225](https://github.com/voxpupuli/puppet-nginx/pull/1225) ([bastelfreak](https://github.com/bastelfreak))

**Merged pull requests:**

- README: Remove old email address [\#1223](https://github.com/voxpupuli/puppet-nginx/pull/1223) ([3flex](https://github.com/3flex))
- Fix documentation typo in location.pp [\#1220](https://github.com/voxpupuli/puppet-nginx/pull/1220) ([swenske](https://github.com/swenske))
- Rely on beaker-hostgenerator for docker nodesets [\#1216](https://github.com/voxpupuli/puppet-nginx/pull/1216) ([ekohl](https://github.com/ekohl))

## [v0.12.0](https://github.com/voxpupuli/puppet-nginx/tree/v0.12.0) (2018-05-11)

[Full Changelog](https://github.com/voxpupuli/puppet-nginx/compare/v0.11.0...v0.12.0)

**Implemented enhancements:**

- Add Debian 9 support [\#1200](https://github.com/voxpupuli/puppet-nginx/pull/1200) ([bastelfreak](https://github.com/bastelfreak))
- Fix indent of autoindex param in server template [\#1195](https://github.com/voxpupuli/puppet-nginx/pull/1195) ([jdmulloy](https://github.com/jdmulloy))

**Fixed bugs:**

- allow people to not purge passenger yumrepo [\#1212](https://github.com/voxpupuli/puppet-nginx/pull/1212) ([bastelfreak](https://github.com/bastelfreak))

**Closed issues:**

- No such file or directory @ dir\_s\_mkdir [\#1202](https://github.com/voxpupuli/puppet-nginx/issues/1202)

**Merged pull requests:**

- increase spec test coverage [\#1214](https://github.com/voxpupuli/puppet-nginx/pull/1214) ([bastelfreak](https://github.com/bastelfreak))
- migrate vars from topscope to relative scope [\#1213](https://github.com/voxpupuli/puppet-nginx/pull/1213) ([bastelfreak](https://github.com/bastelfreak))
- Support setting `ssl\_verify\_depth` in nginx::resource::server [\#1210](https://github.com/voxpupuli/puppet-nginx/pull/1210) ([tdevelioglu](https://github.com/tdevelioglu))
- Update minimum version of puppetlabs/stdlib to 4.22.0 [\#1207](https://github.com/voxpupuli/puppet-nginx/pull/1207) ([JacobHenner](https://github.com/JacobHenner))
- Update readme: listen\_port is integer for Hiera [\#1205](https://github.com/voxpupuli/puppet-nginx/pull/1205) ([AranVinkItility](https://github.com/AranVinkItility))
- bump puppet version dependency to \>= 4.10.0 \< 6.0.0 [\#1203](https://github.com/voxpupuli/puppet-nginx/pull/1203) ([bastelfreak](https://github.com/bastelfreak))
- cleanup spec\_helper\_acceptance [\#1199](https://github.com/voxpupuli/puppet-nginx/pull/1199) ([bastelfreak](https://github.com/bastelfreak))
- add acceptance test to verify default values [\#1198](https://github.com/voxpupuli/puppet-nginx/pull/1198) ([bastelfreak](https://github.com/bastelfreak))

## [v0.11.0](https://github.com/voxpupuli/puppet-nginx/tree/v0.11.0) (2018-03-17)

[Full Changelog](https://github.com/voxpupuli/puppet-nginx/compare/v0.10.0...v0.11.0)

**Implemented enhancements:**

- Add ssl\_ecdh\_curve to server resource [\#1192](https://github.com/voxpupuli/puppet-nginx/pull/1192) ([jdmulloy](https://github.com/jdmulloy))
- add etag support at the http level [\#1183](https://github.com/voxpupuli/puppet-nginx/pull/1183) ([bryangwilliam](https://github.com/bryangwilliam))
- Add proxy send timeout for the nginx server configuration. [\#1181](https://github.com/voxpupuli/puppet-nginx/pull/1181) ([Nitish-SH](https://github.com/Nitish-SH))

**Fixed bugs:**

- nginx package spectest failing  [\#1190](https://github.com/voxpupuli/puppet-nginx/issues/1190)
- Fix \#1190 Accommodate default package name nginx-mainline for Arch Linux [\#1191](https://github.com/voxpupuli/puppet-nginx/pull/1191) ([JacobHenner](https://github.com/JacobHenner))
- use correct nginx package name on archlinux [\#1184](https://github.com/voxpupuli/puppet-nginx/pull/1184) ([bastelfreak](https://github.com/bastelfreak))

**Closed issues:**

- Concat not listet as Requirement in Readme [\#1188](https://github.com/voxpupuli/puppet-nginx/issues/1188)

**Merged pull requests:**

- switch from topscope facts to facts hash [\#1193](https://github.com/voxpupuli/puppet-nginx/pull/1193) ([bastelfreak](https://github.com/bastelfreak))
- modulesync 1.18.0 & enhance acceptance test matrix [\#1185](https://github.com/voxpupuli/puppet-nginx/pull/1185) ([bastelfreak](https://github.com/bastelfreak))

## [v0.10.0](https://github.com/voxpupuli/puppet-nginx/tree/v0.10.0) (2018-02-11)

[Full Changelog](https://github.com/voxpupuli/puppet-nginx/compare/v0.9.0...v0.10.0)

**Implemented enhancements:**

- Add more per-location proxy options: proxy\_send\_timeout, proxy\_ignore… [\#1169](https://github.com/voxpupuli/puppet-nginx/pull/1169) ([merclangrat](https://github.com/merclangrat))
- Add add\_header parameter to location [\#1160](https://github.com/voxpupuli/puppet-nginx/pull/1160) ([alexjfisher](https://github.com/alexjfisher))
- Use $service\_name for service resource title. [\#1159](https://github.com/voxpupuli/puppet-nginx/pull/1159) ([fnoop](https://github.com/fnoop))

**Fixed bugs:**

- Fix syntax error in ERB template for fastcgi location. [\#1168](https://github.com/voxpupuli/puppet-nginx/pull/1168) ([rpasing](https://github.com/rpasing))

**Closed issues:**

- duplicating proxy\_cache\_path value [\#1175](https://github.com/voxpupuli/puppet-nginx/issues/1175)
- allow/deny and auth\_basic\_user\_file should be in the location [\#1172](https://github.com/voxpupuli/puppet-nginx/issues/1172)
- Service resource name conflicts with system service [\#1158](https://github.com/voxpupuli/puppet-nginx/issues/1158)

**Merged pull requests:**

- add missing autoindex parameter in template of server resource [\#1174](https://github.com/voxpupuli/puppet-nginx/pull/1174) ([joekohlsdorf](https://github.com/joekohlsdorf))
- Compatibility with puppetlabs-apt 4.4.0 [\#1163](https://github.com/voxpupuli/puppet-nginx/pull/1163) ([ekohl](https://github.com/ekohl))
- replace validate\_\* with datatypes in resource::map [\#1157](https://github.com/voxpupuli/puppet-nginx/pull/1157) ([bastelfreak](https://github.com/bastelfreak))
- Remove EOL operatingsystems [\#1153](https://github.com/voxpupuli/puppet-nginx/pull/1153) ([ekohl](https://github.com/ekohl))
- adding support for proxy\_cache\_bypass and proxy\_cache\_lock [\#1150](https://github.com/voxpupuli/puppet-nginx/pull/1150) ([ceonizm](https://github.com/ceonizm))
- adding support for include directive in map [\#1149](https://github.com/voxpupuli/puppet-nginx/pull/1149) ([ceonizm](https://github.com/ceonizm))

## [v0.9.0](https://github.com/voxpupuli/puppet-nginx/tree/v0.9.0) (2017-11-11)

[Full Changelog](https://github.com/voxpupuli/puppet-nginx/compare/v0.8.0...v0.9.0)

**Implemented enhancements:**

- Suffix timeout values with second indicator [\#1138](https://github.com/voxpupuli/puppet-nginx/pull/1138) ([rudybroersma](https://github.com/rudybroersma))

**Fixed bugs:**

- nginx\_locations appearing in the wrong location in the config file [\#1142](https://github.com/voxpupuli/puppet-nginx/issues/1142)
- invalid config generated when ssl is false and listen\_port == ssl\_port [\#648](https://github.com/voxpupuli/puppet-nginx/issues/648)
- Confine NGINX version fact to exclude Cisco Nexus switches [\#1140](https://github.com/voxpupuli/puppet-nginx/pull/1140) ([murdok5](https://github.com/murdok5))

**Closed issues:**

- Including nginx class not working due too nginx\_error\_log\_severity parameter [\#1143](https://github.com/voxpupuli/puppet-nginx/issues/1143)
- http\_format\_log for nginx servers  [\#1139](https://github.com/voxpupuli/puppet-nginx/issues/1139)
- Incorrect default timeout values [\#1137](https://github.com/voxpupuli/puppet-nginx/issues/1137)
- setting index files to undef doesn't work as expected [\#1128](https://github.com/voxpupuli/puppet-nginx/issues/1128)

**Merged pull requests:**

- Doc-only: Fix proxy/blog location reference [\#1144](https://github.com/voxpupuli/puppet-nginx/pull/1144) ([tarnation](https://github.com/tarnation))
- add settable nginx daemon group [\#1126](https://github.com/voxpupuli/puppet-nginx/pull/1126) ([miksercz](https://github.com/miksercz))

## [v0.8.0](https://github.com/voxpupuli/puppet-nginx/tree/v0.8.0) (2017-10-10)

[Full Changelog](https://github.com/voxpupuli/puppet-nginx/compare/v0.7.1...v0.8.0)

**Fixed bugs:**

- Please add a 'warn' when someone is using 'nginx::resource::vhost' without previously including the nginx class [\#983](https://github.com/voxpupuli/puppet-nginx/issues/983)

**Merged pull requests:**

- Improve logic for ipv6 listening [\#1131](https://github.com/voxpupuli/puppet-nginx/pull/1131) ([xaque208](https://github.com/xaque208))
- Remove 'Optional' for resources with default settings [\#1130](https://github.com/voxpupuli/puppet-nginx/pull/1130) ([wyardley](https://github.com/wyardley))
- Remove Optional for index\_files \(\#1128\) [\#1129](https://github.com/voxpupuli/puppet-nginx/pull/1129) ([wyardley](https://github.com/wyardley))
- Fix indent auth\_basic\_user\_file ssl server [\#1122](https://github.com/voxpupuli/puppet-nginx/pull/1122) ([fe80](https://github.com/fe80))
- Release 0.7.1 [\#1119](https://github.com/voxpupuli/puppet-nginx/pull/1119) ([wyardley](https://github.com/wyardley))
- Fail defined types if nginx class was not declared before [\#1070](https://github.com/voxpupuli/puppet-nginx/pull/1070) ([vinzent](https://github.com/vinzent))

## [v0.7.1](https://github.com/voxpupuli/puppet-nginx/tree/v0.7.1) (2017-09-01)

[Full Changelog](https://github.com/voxpupuli/puppet-nginx/compare/v0.7.0...v0.7.1)

**Breaking changes:**

- Optional parameters should default to undef and not false [\#1048](https://github.com/voxpupuli/puppet-nginx/issues/1048)
- Don't allow strings to be given for integer parameters [\#1047](https://github.com/voxpupuli/puppet-nginx/issues/1047)

**Closed issues:**

- Support puppetlabs/concat \>= 4.0 [\#1117](https://github.com/voxpupuli/puppet-nginx/issues/1117)
- Unable to include module's [\#1112](https://github.com/voxpupuli/puppet-nginx/issues/1112)
- puppet-nginx requires outdated module dependencies [\#1107](https://github.com/voxpupuli/puppet-nginx/issues/1107)
- ensure =\> 'absent' on nginx::resource::server leaves file behind [\#1103](https://github.com/voxpupuli/puppet-nginx/issues/1103)
- Hiera/Problem with concat:  Target Concat\_file with path of ... not found in the catalog [\#1102](https://github.com/voxpupuli/puppet-nginx/issues/1102)
- Bump puppetlabs/apt dependency [\#1086](https://github.com/voxpupuli/puppet-nginx/issues/1086)
- Custom nginx.conf template is no longer working [\#1083](https://github.com/voxpupuli/puppet-nginx/issues/1083)
- Hiera merge with multiple yaml files [\#614](https://github.com/voxpupuli/puppet-nginx/issues/614)

**Merged pull requests:**

- fix lint warnings [\#1115](https://github.com/voxpupuli/puppet-nginx/pull/1115) ([PascalBourdier](https://github.com/PascalBourdier))
- Add DragonFly BSD support [\#1111](https://github.com/voxpupuli/puppet-nginx/pull/1111) ([strangelittlemonkey](https://github.com/strangelittlemonkey))
- Fix dependency on apt-transport-https [\#1110](https://github.com/voxpupuli/puppet-nginx/pull/1110) ([rvdh](https://github.com/rvdh))
- bump concat to \<5.0.0 instead of \<4.0.0 \(\#1107\) [\#1108](https://github.com/voxpupuli/puppet-nginx/pull/1108) ([wyardley](https://github.com/wyardley))
- make apt a soft dependency per styleguide \(resolves \#1086\) [\#1106](https://github.com/voxpupuli/puppet-nginx/pull/1106) ([wyardley](https://github.com/wyardley))
- Ensure absent on concat resource for server resource with ensure =\> absent \(\#1103\) [\#1104](https://github.com/voxpupuli/puppet-nginx/pull/1104) ([wyardley](https://github.com/wyardley))
- Release 0.7.0 [\#1099](https://github.com/voxpupuli/puppet-nginx/pull/1099) ([alexjfisher](https://github.com/alexjfisher))

## [v0.7.0](https://github.com/voxpupuli/puppet-nginx/tree/v0.7.0) (2017-08-01)

[Full Changelog](https://github.com/voxpupuli/puppet-nginx/compare/v0.6.0...v0.7.0)

**Breaking changes:**

- replace validate\_\* calles with datatypes in server.pp [\#1057](https://github.com/voxpupuli/puppet-nginx/pull/1057) ([bastelfreak](https://github.com/bastelfreak))
- replace validate\_\* with datatypes [\#1056](https://github.com/voxpupuli/puppet-nginx/pull/1056) ([bastelfreak](https://github.com/bastelfreak))
- BREAKING: Drop puppet 3 support. Replace validate\_\* calls with datatypes in location.pp [\#1050](https://github.com/voxpupuli/puppet-nginx/pull/1050) ([bastelfreak](https://github.com/bastelfreak))
- change fastcgi\_cache\_key default false-\>undef [\#1049](https://github.com/voxpupuli/puppet-nginx/pull/1049) ([bastelfreak](https://github.com/bastelfreak))
- change fastcgi\_cache\_use\_stale default false-\>undef [\#1045](https://github.com/voxpupuli/puppet-nginx/pull/1045) ([bastelfreak](https://github.com/bastelfreak))
- change fastcgi\_cache\_path default false-\>undef [\#1044](https://github.com/voxpupuli/puppet-nginx/pull/1044) ([bastelfreak](https://github.com/bastelfreak))
- change http\_cfg\_prepend default false-\>undef [\#1043](https://github.com/voxpupuli/puppet-nginx/pull/1043) ([bastelfreak](https://github.com/bastelfreak))
- change http\_cfg\_append default false-\>undef [\#1042](https://github.com/voxpupuli/puppet-nginx/pull/1042) ([bastelfreak](https://github.com/bastelfreak))
- change events\_use default false-\>undef [\#1041](https://github.com/voxpupuli/puppet-nginx/pull/1041) ([bastelfreak](https://github.com/bastelfreak))
- change worker\_rlimit\_nofile default string-\>int [\#1040](https://github.com/voxpupuli/puppet-nginx/pull/1040) ([bastelfreak](https://github.com/bastelfreak))
- change worker\_processes default string-\>int [\#1039](https://github.com/voxpupuli/puppet-nginx/pull/1039) ([bastelfreak](https://github.com/bastelfreak))
- change names\_hash\_bucket\_size default string-\>int [\#1038](https://github.com/voxpupuli/puppet-nginx/pull/1038) ([bastelfreak](https://github.com/bastelfreak))
- change names\_hash\_max\_size default string-\>int [\#1037](https://github.com/voxpupuli/puppet-nginx/pull/1037) ([bastelfreak](https://github.com/bastelfreak))
- change proxy\_cache\_path default false-\>undef [\#1036](https://github.com/voxpupuli/puppet-nginx/pull/1036) ([bastelfreak](https://github.com/bastelfreak))
- change proxy\_use\_temp\_path default false-\>undef [\#1035](https://github.com/voxpupuli/puppet-nginx/pull/1035) ([bastelfreak](https://github.com/bastelfreak))
- change proxy\_headers\_hash\_bucket\_size default string-\>int [\#1034](https://github.com/voxpupuli/puppet-nginx/pull/1034) ([bastelfreak](https://github.com/bastelfreak))
- change worker\_connections default string-\>int [\#1033](https://github.com/voxpupuli/puppet-nginx/pull/1033) ([bastelfreak](https://github.com/bastelfreak))
- BREAKING: Drop puppet 3 support. Replace validate\_\* with datatypes [\#1031](https://github.com/voxpupuli/puppet-nginx/pull/1031) ([bastelfreak](https://github.com/bastelfreak))

**Implemented enhancements:**

- Fix deprecated apt::source usage [\#995](https://github.com/voxpupuli/puppet-nginx/issues/995)
- Allow default ssl\_dhparam to be set in base class [\#1096](https://github.com/voxpupuli/puppet-nginx/pull/1096) ([alexjfisher](https://github.com/alexjfisher))
- Allow index\_files =\> undef in resource::server class [\#1094](https://github.com/voxpupuli/puppet-nginx/pull/1094) ([walkamongus](https://github.com/walkamongus))
- Add http\_raw\_prepend and http\_raw\_append parameters [\#1093](https://github.com/voxpupuli/puppet-nginx/pull/1093) ([walkamongus](https://github.com/walkamongus))
- Use nginx defaults for fastcgi\_params / uwsgi\_params [\#1076](https://github.com/voxpupuli/puppet-nginx/pull/1076) ([wyardley](https://github.com/wyardley))
- Add hiera nginx\_mailhosts\_defaults like nginx\_servers\_defaults [\#1068](https://github.com/voxpupuli/puppet-nginx/pull/1068) ([dol](https://github.com/dol))
- Make ssl\_prefer\_server\_ciphers configurable in server / mailhost [\#1067](https://github.com/voxpupuli/puppet-nginx/pull/1067) ([wyardley](https://github.com/wyardley))
- Avoid spurious location block when redirecting to SSL in another server block [\#1066](https://github.com/voxpupuli/puppet-nginx/pull/1066) ([oranenj](https://github.com/oranenj))
- Add fastcgi index [\#1062](https://github.com/voxpupuli/puppet-nginx/pull/1062) ([elmobp](https://github.com/elmobp))
- Warn if $ssl=false but $ssl\_port == $listen\_port \(\#1015\) [\#1022](https://github.com/voxpupuli/puppet-nginx/pull/1022) ([wyardley](https://github.com/wyardley))
- Switch apt::source key from string to hash. [\#1016](https://github.com/voxpupuli/puppet-nginx/pull/1016) ([darkstego](https://github.com/darkstego))

**Fixed bugs:**

- Can't pass 'always' parameter to add\_header due to single quoting [\#1020](https://github.com/voxpupuli/puppet-nginx/issues/1020)
- Fix permissions on fastcgi\_params and uwsgi\_params files \(\#1002\) [\#1003](https://github.com/voxpupuli/puppet-nginx/pull/1003) ([wyardley](https://github.com/wyardley))

**Closed issues:**

- ssl\_dhparam no longer an option [\#1084](https://github.com/voxpupuli/puppet-nginx/issues/1084)
- 'Cannot create a location reference without' rather annoying and blocks some possibilities [\#1074](https://github.com/voxpupuli/puppet-nginx/issues/1074)
- Invalid parameter ensure at redhat.pp:49 [\#1065](https://github.com/voxpupuli/puppet-nginx/issues/1065)
- Unable to control fastcgi\_params from module? [\#1064](https://github.com/voxpupuli/puppet-nginx/issues/1064)
- fastcgi\_params file when set to non-default path if File resource not declared [\#1063](https://github.com/voxpupuli/puppet-nginx/issues/1063)
- Make ssl\_prefer\_server\_ciphers a variable [\#1032](https://github.com/voxpupuli/puppet-nginx/issues/1032)
- nginx 0.6.0: bad location block causes nginx restart to fail [\#1029](https://github.com/voxpupuli/puppet-nginx/issues/1029)
- Add "udp" for "listen\_port" parameter, add stream resource example into README [\#1019](https://github.com/voxpupuli/puppet-nginx/issues/1019)
- Using ssl\_port without ssl =\> true makes module fail silently [\#1015](https://github.com/voxpupuli/puppet-nginx/issues/1015)
- uninitialized constant Puppet::Type::Concat\_file error after upgrade from 0.5.0 to 0.6.0 [\#1008](https://github.com/voxpupuli/puppet-nginx/issues/1008)
- $location\_sanitized variable present in code but unused [\#1006](https://github.com/voxpupuli/puppet-nginx/issues/1006)
- fastcgi\_params file set to permission 770 by default [\#1002](https://github.com/voxpupuli/puppet-nginx/issues/1002)
- Add Oracle as one of Redhat operating systems for params file [\#988](https://github.com/voxpupuli/puppet-nginx/issues/988)
- Adding a simple vhost not as simple as it seems [\#887](https://github.com/voxpupuli/puppet-nginx/issues/887)

**Merged pull requests:**

- Fix misspelling [\#1095](https://github.com/voxpupuli/puppet-nginx/pull/1095) ([rdev5](https://github.com/rdev5))
- Use correct scheme with rewrite\_www\_to\_non\_www [\#1091](https://github.com/voxpupuli/puppet-nginx/pull/1091) ([alfoeternia](https://github.com/alfoeternia))
- Use rspec-puppet-facts [\#1090](https://github.com/voxpupuli/puppet-nginx/pull/1090) ([alexjfisher](https://github.com/alexjfisher))
- Clean up nginx::resource::server [\#1082](https://github.com/voxpupuli/puppet-nginx/pull/1082) ([ekohl](https://github.com/ekohl))
- Bump puppetlabs-concat, puppetlabs-stdlib and Puppet minimum versions [\#1081](https://github.com/voxpupuli/puppet-nginx/pull/1081) ([tdevelioglu](https://github.com/tdevelioglu))
- set manage\_repo for Oracle "RedHat" \(and not 5.x for any flavor anymore, for consistency with rest of module\) [\#1077](https://github.com/voxpupuli/puppet-nginx/pull/1077) ([wyardley](https://github.com/wyardley))
- Remove location check of some random values to be set in the context of location [\#1075](https://github.com/voxpupuli/puppet-nginx/pull/1075) ([dol](https://github.com/dol))
- Adding FastCGI index [\#1073](https://github.com/voxpupuli/puppet-nginx/pull/1073) ([elmobp](https://github.com/elmobp))
- Revert "Add fastcgi index" [\#1072](https://github.com/voxpupuli/puppet-nginx/pull/1072) ([wyardley](https://github.com/wyardley))
- Add location defaults to init and server resource [\#1071](https://github.com/voxpupuli/puppet-nginx/pull/1071) ([dol](https://github.com/dol))
- Use some more puppet 4 features to reduce code [\#1058](https://github.com/voxpupuli/puppet-nginx/pull/1058) ([igalic](https://github.com/igalic))
- Update README's puppet requirement section [\#1054](https://github.com/voxpupuli/puppet-nginx/pull/1054) ([alexjfisher](https://github.com/alexjfisher))
- docs fix from @jurim76 [\#1021](https://github.com/voxpupuli/puppet-nginx/pull/1021) ([wyardley](https://github.com/wyardley))
- Fixed typo in changelog notes: ssl\_force\_redirect -\> ssl\_redirect. [\#1013](https://github.com/voxpupuli/puppet-nginx/pull/1013) ([triforce](https://github.com/triforce))
- Changed upstream\_member.erb template directory path to match new loca… [\#1012](https://github.com/voxpupuli/puppet-nginx/pull/1012) ([triforce](https://github.com/triforce))
- Remove unused variables [\#1007](https://github.com/voxpupuli/puppet-nginx/pull/1007) ([mattkenn4545](https://github.com/mattkenn4545))
- Update README.md [\#1000](https://github.com/voxpupuli/puppet-nginx/pull/1000) ([Cinderhaze](https://github.com/Cinderhaze))
- Use double, vs single quotes around add\_header values \(\#991\) [\#992](https://github.com/voxpupuli/puppet-nginx/pull/992) ([wyardley](https://github.com/wyardley))

## [v0.6.0](https://github.com/voxpupuli/puppet-nginx/tree/v0.6.0) (2017-01-13)

[Full Changelog](https://github.com/voxpupuli/puppet-nginx/compare/v0.5.0...v0.6.0)

**Breaking changes:**

- Rename v\[hH\]ost to server everywhere [\#980](https://github.com/voxpupuli/puppet-nginx/pull/980) ([sacres](https://github.com/sacres))
- Rename rewrite\_to\_https =\> ssl\_redirect \(backwards-incompatible change\) [\#957](https://github.com/voxpupuli/puppet-nginx/pull/957) ([wyardley](https://github.com/wyardley))
- Major change: Rework namespace \(get rid of ::config namespace again\) [\#950](https://github.com/voxpupuli/puppet-nginx/pull/950) ([wyardley](https://github.com/wyardley))

**Implemented enhancements:**

- HTTP-\>HTTPS [\#818](https://github.com/voxpupuli/puppet-nginx/issues/818)
- nginx\_cfg\_prepend missing in nginx class [\#771](https://github.com/voxpupuli/puppet-nginx/issues/771)
- upstream\_cfg\_append [\#717](https://github.com/voxpupuli/puppet-nginx/issues/717)
- Nested Locations [\#692](https://github.com/voxpupuli/puppet-nginx/issues/692)
- Log directory ownership and permissions do not respect OS [\#664](https://github.com/voxpupuli/puppet-nginx/issues/664)
- Current setup of gpgcheck in redhat package is insecure [\#651](https://github.com/voxpupuli/puppet-nginx/issues/651)
- Cannot purge unmanaged Upstreams [\#495](https://github.com/voxpupuli/puppet-nginx/issues/495)
- Nginx configuration [\#161](https://github.com/voxpupuli/puppet-nginx/issues/161)

**Fixed bugs:**

- include /etc/nginx/streams-available|enabled not in nginx.conf.erb [\#780](https://github.com/voxpupuli/puppet-nginx/issues/780)
- Cannot set both location\_alias and fastcgi at the same time on a location [\#591](https://github.com/voxpupuli/puppet-nginx/issues/591)

**Closed issues:**

- What's the correct way to set config options now? [\#978](https://github.com/voxpupuli/puppet-nginx/issues/978)
- Allow access\_log to be an array [\#975](https://github.com/voxpupuli/puppet-nginx/issues/975)
- nginx::locations puts locations in wrong order [\#971](https://github.com/voxpupuli/puppet-nginx/issues/971)
- No allowance for custom nginx source? [\#962](https://github.com/voxpupuli/puppet-nginx/issues/962)
- Upstreams do not depend on package [\#942](https://github.com/voxpupuli/puppet-nginx/issues/942)
- Support for Ubuntu 16.04? [\#935](https://github.com/voxpupuli/puppet-nginx/issues/935)
- How to use  nginx::resource::vhost:add\_header ? [\#899](https://github.com/voxpupuli/puppet-nginx/issues/899)
- nginx::resource::upstream with no members can only be called once [\#897](https://github.com/voxpupuli/puppet-nginx/issues/897)
- vhost\_cfg\_append with multiple entries having the same name \(rewrite\) not possible [\#807](https://github.com/voxpupuli/puppet-nginx/issues/807)
- ssl\_cert and ssl\_key are required [\#743](https://github.com/voxpupuli/puppet-nginx/issues/743)
- Cannot deny access via location [\#741](https://github.com/voxpupuli/puppet-nginx/issues/741)
- A negative configtest should be reported as a fail/error [\#722](https://github.com/voxpupuli/puppet-nginx/issues/722)
- Changing the vhost / location doesn't reload the server [\#706](https://github.com/voxpupuli/puppet-nginx/issues/706)
- fastcgi\_params should not be creating non-standard files by default [\#682](https://github.com/voxpupuli/puppet-nginx/issues/682)
- Specifying `keepalive` and `least\_conn` in `upstream` gives warning. [\#641](https://github.com/voxpupuli/puppet-nginx/issues/641)
- www\_root is not being added correctly [\#639](https://github.com/voxpupuli/puppet-nginx/issues/639)
- Hiera documentation bug [\#556](https://github.com/voxpupuli/puppet-nginx/issues/556)
- Issues with fastcgi\_params [\#499](https://github.com/voxpupuli/puppet-nginx/issues/499)
- proxy\_set\_header does not support X-Forwarded-Proto and X-Forwarded-Port [\#476](https://github.com/voxpupuli/puppet-nginx/issues/476)
- proxy\_redirect default value [\#395](https://github.com/voxpupuli/puppet-nginx/issues/395)
- Rename vhost to server.d [\#348](https://github.com/voxpupuli/puppet-nginx/issues/348)

**Merged pull requests:**

- Bump minimum version dependencies \(for Puppet 4\) [\#993](https://github.com/voxpupuli/puppet-nginx/pull/993) ([juniorsysadmin](https://github.com/juniorsysadmin))
- Bump puppet minimum version\_requirement to 3.8.7 [\#989](https://github.com/voxpupuli/puppet-nginx/pull/989) ([juniorsysadmin](https://github.com/juniorsysadmin))
- add passenger\_package\_ensure parameter to allow pinning passenger version [\#987](https://github.com/voxpupuli/puppet-nginx/pull/987) ([wyardley](https://github.com/wyardley))
- Added auth\_request configuration capability [\#986](https://github.com/voxpupuli/puppet-nginx/pull/986) ([mvisonneau](https://github.com/mvisonneau))
- Add support for proxy\_cache\_path loader directives [\#984](https://github.com/voxpupuli/puppet-nginx/pull/984) ([carroarmato0](https://github.com/carroarmato0))
- Document include param for location and fix whitespace issue \(issue \#976\) [\#977](https://github.com/voxpupuli/puppet-nginx/pull/977) ([srinchiera](https://github.com/srinchiera))
- fix validation range for location priority [\#972](https://github.com/voxpupuli/puppet-nginx/pull/972) ([wyardley](https://github.com/wyardley))
- Reorganize templates for clearer understanding [\#970](https://github.com/voxpupuli/puppet-nginx/pull/970) ([xaque208](https://github.com/xaque208))
- Put keepalive at bottom of upstream\_cfg\_{append,prepend} sections \(\#641\) [\#969](https://github.com/voxpupuli/puppet-nginx/pull/969) ([wyardley](https://github.com/wyardley))
- allow try\_files and index in location resource [\#966](https://github.com/voxpupuli/puppet-nginx/pull/966) ([wyardley](https://github.com/wyardley))
- Fix Bug: ensure =\> absent was not working on nginx::resource::location [\#965](https://github.com/voxpupuli/puppet-nginx/pull/965) ([artberri](https://github.com/artberri))
- fix map.erb to work on Redhat 6 releases [\#963](https://github.com/voxpupuli/puppet-nginx/pull/963) ([mbelscher](https://github.com/mbelscher))
- Set log directory ownership / permissions explicitly [\#959](https://github.com/voxpupuli/puppet-nginx/pull/959) ([wyardley](https://github.com/wyardley))
- Add 'require' for parent dir of upstream, map, and geo configs as wel… [\#958](https://github.com/voxpupuli/puppet-nginx/pull/958) ([wyardley](https://github.com/wyardley))
- Add fastcgi\_param parameter to vhost resource [\#956](https://github.com/voxpupuli/puppet-nginx/pull/956) ([xaque208](https://github.com/xaque208))
- Allow setting $daemon to "on" or "off" \(defaults to unset\) [\#955](https://github.com/voxpupuli/puppet-nginx/pull/955) ([wyardley](https://github.com/wyardley))
- Add upstream\_cfg\_append \(to match prepend\) [\#953](https://github.com/voxpupuli/puppet-nginx/pull/953) ([wyardley](https://github.com/wyardley))
- fix rubocop failures after rubocop version update [\#952](https://github.com/voxpupuli/puppet-nginx/pull/952) ([wyardley](https://github.com/wyardley))
- officially add Ubuntu 1604 support [\#951](https://github.com/voxpupuli/puppet-nginx/pull/951) ([wyardley](https://github.com/wyardley))
- docs changes to reflect upcoming changes [\#949](https://github.com/voxpupuli/puppet-nginx/pull/949) ([wyardley](https://github.com/wyardley))
- default proxy\_redirect to undef in locations \(resolves \#395\) [\#948](https://github.com/voxpupuli/puppet-nginx/pull/948) ([wyardley](https://github.com/wyardley))
- Use SSL for nginx APT repository [\#939](https://github.com/voxpupuli/puppet-nginx/pull/939) ([saz](https://github.com/saz))
- Adds new SSL && protocol specific directives to mailhost setup [\#769](https://github.com/voxpupuli/puppet-nginx/pull/769) ([dol](https://github.com/dol))
- add $members\_tag parameter to nginx::resource::upstream [\#755](https://github.com/voxpupuli/puppet-nginx/pull/755) ([brunoleon](https://github.com/brunoleon))

## [v0.5.0](https://github.com/voxpupuli/puppet-nginx/tree/v0.5.0) (2016-10-27)

[Full Changelog](https://github.com/voxpupuli/puppet-nginx/compare/v0.4.0...v0.5.0)

**Implemented enhancements:**

- Add "disable\_symlinks" option for nginx::config class [\#847](https://github.com/voxpupuli/puppet-nginx/issues/847)
- Do not re-order parameters in location\_custom\_cfg alphabetically [\#828](https://github.com/voxpupuli/puppet-nginx/issues/828)
- how to set large\_client\_header\_buffers ? [\#737](https://github.com/voxpupuli/puppet-nginx/issues/737)
- Allow and Deny directives... [\#662](https://github.com/voxpupuli/puppet-nginx/issues/662)
- Passenger Packages for CentOS/RHEL! [\#633](https://github.com/voxpupuli/puppet-nginx/issues/633)
- Cannot set ip\_hash via Hiera [\#563](https://github.com/voxpupuli/puppet-nginx/issues/563)
- Get more friendly with concat [\#538](https://github.com/voxpupuli/puppet-nginx/issues/538)
- Multiple listen ip addresses \(v4 and/or v6\) [\#515](https://github.com/voxpupuli/puppet-nginx/issues/515)
- Add a custom response header for a location [\#511](https://github.com/voxpupuli/puppet-nginx/issues/511)
- vhost that binds to 'any host' -\> no server\_name [\#506](https://github.com/voxpupuli/puppet-nginx/issues/506)
- fastcgi\_param https [\#492](https://github.com/voxpupuli/puppet-nginx/issues/492)
- cannot create location with only try\_files defined [\#470](https://github.com/voxpupuli/puppet-nginx/issues/470)
- Should fail compilation when default location created for vhost without other required parameters [\#447](https://github.com/voxpupuli/puppet-nginx/issues/447)
- Windows Support [\#436](https://github.com/voxpupuli/puppet-nginx/issues/436)
- Any way to specify multiple listening ports? [\#433](https://github.com/voxpupuli/puppet-nginx/issues/433)
- Add map\_hash\_bucket\_size and map\_hash\_max\_size [\#429](https://github.com/voxpupuli/puppet-nginx/issues/429)
- Catch all requests with wrong host and return 444 status [\#261](https://github.com/voxpupuli/puppet-nginx/issues/261)
- Add uwsgi\_pass [\#160](https://github.com/voxpupuli/puppet-nginx/issues/160)
- Global options for ssl ciphers [\#823](https://github.com/voxpupuli/puppet-nginx/pull/823) ([jkroepke](https://github.com/jkroepke))

**Fixed bugs:**

- Facter Rspec tests hangs on 2.3.0 [\#917](https://github.com/voxpupuli/puppet-nginx/issues/917)
- Secure configs for php-fpm/pathinfo [\#735](https://github.com/voxpupuli/puppet-nginx/issues/735)
- Adding iphash to Upstream has no effect [\#661](https://github.com/voxpupuli/puppet-nginx/issues/661)
- puppet tries to create vhost before nginx is installed? [\#610](https://github.com/voxpupuli/puppet-nginx/issues/610)
- Move try\_files [\#736](https://github.com/voxpupuli/puppet-nginx/pull/736) ([jkroepke](https://github.com/jkroepke))

**Closed issues:**

- remove $configtest\_enable parameter, look into nginx::service in general [\#916](https://github.com/voxpupuli/puppet-nginx/issues/916)
- Location code before server code in ssl\_nodes [\#915](https://github.com/voxpupuli/puppet-nginx/issues/915)
- Warning and refresh even with no configs in the class declaration [\#905](https://github.com/voxpupuli/puppet-nginx/issues/905)
- log\_dir works in vhost context, but not in main context [\#895](https://github.com/voxpupuli/puppet-nginx/issues/895)
- No require for File: sites-enabled and sites-available folders [\#894](https://github.com/voxpupuli/puppet-nginx/issues/894)
- Cannot set ssl log paths when overriding access and error logs [\#893](https://github.com/voxpupuli/puppet-nginx/issues/893)
- Improvement of the hiera-related documentation [\#892](https://github.com/voxpupuli/puppet-nginx/issues/892)
- sites-enabled on redhat? [\#889](https://github.com/voxpupuli/puppet-nginx/issues/889)
- acceptance tests with new\(ish\) Beaker version [\#882](https://github.com/voxpupuli/puppet-nginx/issues/882)
- Vox Pupuli Elections [\#871](https://github.com/voxpupuli/puppet-nginx/issues/871)
- RFC: Upstream vs distro packages [\#863](https://github.com/voxpupuli/puppet-nginx/issues/863)
- secure ssl configuration [\#859](https://github.com/voxpupuli/puppet-nginx/issues/859)
- Add File Output Preview [\#846](https://github.com/voxpupuli/puppet-nginx/issues/846)
- Looking for Maintainer [\#844](https://github.com/voxpupuli/puppet-nginx/issues/844)
- Is this module still "undergoing some structural maintenance"? [\#809](https://github.com/voxpupuli/puppet-nginx/issues/809)
- 'server {' stanza [\#792](https://github.com/voxpupuli/puppet-nginx/issues/792)
- /etc/nginx/mime.types file not found [\#791](https://github.com/voxpupuli/puppet-nginx/issues/791)
- white space [\#742](https://github.com/voxpupuli/puppet-nginx/issues/742)
- Little help request [\#733](https://github.com/voxpupuli/puppet-nginx/issues/733)
- Gzip values aren't passed incorrectly to nginx server [\#718](https://github.com/voxpupuli/puppet-nginx/issues/718)
- location if statement [\#713](https://github.com/voxpupuli/puppet-nginx/issues/713)
- Allow multiple access\_log within server{} \( files + syslog \) [\#710](https://github.com/voxpupuli/puppet-nginx/issues/710)
- changing upstream and applying configuration does reload or restart? [\#708](https://github.com/voxpupuli/puppet-nginx/issues/708)
- Location ordering [\#686](https://github.com/voxpupuli/puppet-nginx/issues/686)
- Parameters for log\_format [\#678](https://github.com/voxpupuli/puppet-nginx/issues/678)
- Package installs yum repo despite manage\_repo setting [\#653](https://github.com/voxpupuli/puppet-nginx/issues/653)
- Multiple Locations [\#645](https://github.com/voxpupuli/puppet-nginx/issues/645)
- How to insert conditionals into location [\#617](https://github.com/voxpupuli/puppet-nginx/issues/617)
- proxy\_http\_version setting [\#615](https://github.com/voxpupuli/puppet-nginx/issues/615)
- Defining vhosts in Hiera [\#566](https://github.com/voxpupuli/puppet-nginx/issues/566)
- Default params problem [\#554](https://github.com/voxpupuli/puppet-nginx/issues/554)
- Hiera lookup [\#536](https://github.com/voxpupuli/puppet-nginx/issues/536)
- Manage\_repo is missing in nginx::config [\#535](https://github.com/voxpupuli/puppet-nginx/issues/535)
- properties of members of an upstream [\#475](https://github.com/voxpupuli/puppet-nginx/issues/475)
- main class has no autoindex implementation [\#229](https://github.com/voxpupuli/puppet-nginx/issues/229)
- Right way to proxy a ssl server? [\#217](https://github.com/voxpupuli/puppet-nginx/issues/217)
- Root should not be inside location block [\#142](https://github.com/voxpupuli/puppet-nginx/issues/142)

**Merged pull requests:**

- Remove duplicate badges [\#947](https://github.com/voxpupuli/puppet-nginx/pull/947) ([dhoppe](https://github.com/dhoppe))
- Add missing badges [\#946](https://github.com/voxpupuli/puppet-nginx/pull/946) ([dhoppe](https://github.com/dhoppe))
- Allow vhost ssl cert andn key inheritance from http section [\#945](https://github.com/voxpupuli/puppet-nginx/pull/945) ([jeffmccune](https://github.com/jeffmccune))
- add before =\> Package\['nginx'\] on repo absent ensures [\#944](https://github.com/voxpupuli/puppet-nginx/pull/944) ([wyardley](https://github.com/wyardley))
- version bump and changelog for 0.5.0 [\#943](https://github.com/voxpupuli/puppet-nginx/pull/943) ([wyardley](https://github.com/wyardley))
- Delete .ruby-version [\#936](https://github.com/voxpupuli/puppet-nginx/pull/936) ([dhoppe](https://github.com/dhoppe))
- Allow mappings to be supplied as array of hashes. [\#934](https://github.com/voxpupuli/puppet-nginx/pull/934) ([wyardley](https://github.com/wyardley))
- Fix streamhost support [\#933](https://github.com/voxpupuli/puppet-nginx/pull/933) ([wyardley](https://github.com/wyardley))
- Support array as well as string for passenger\_pre\_start [\#931](https://github.com/voxpupuli/puppet-nginx/pull/931) ([wyardley](https://github.com/wyardley))
- Use default ssl\_protocols for ssl mailhosts [\#930](https://github.com/voxpupuli/puppet-nginx/pull/930) ([ekohl](https://github.com/ekohl))
- add debugging information in error message  [\#928](https://github.com/voxpupuli/puppet-nginx/pull/928) ([wyardley](https://github.com/wyardley))
- Restore $service\_restart, now defaulting to undefined, but now withou… [\#927](https://github.com/voxpupuli/puppet-nginx/pull/927) ([wyardley](https://github.com/wyardley))
- uwsgi: allow custom uwsgi\_param directives [\#926](https://github.com/voxpupuli/puppet-nginx/pull/926) ([darken99](https://github.com/darken99))
- Deprecate \(RHEL 5, Debian 5-6, Ubuntu 10.04\) in module metadata [\#925](https://github.com/voxpupuli/puppet-nginx/pull/925) ([wyardley](https://github.com/wyardley))
- Add expires directive to location [\#924](https://github.com/voxpupuli/puppet-nginx/pull/924) ([wyardley](https://github.com/wyardley))
- Allow location\_allow / location\_deny as well in location blocks [\#923](https://github.com/voxpupuli/puppet-nginx/pull/923) ([wyardley](https://github.com/wyardley))
- Support for proxy\_pass\_header directive. [\#922](https://github.com/voxpupuli/puppet-nginx/pull/922) ([gallagherrchris](https://github.com/gallagherrchris))
- Remove broken configtest\_enable option [\#921](https://github.com/voxpupuli/puppet-nginx/pull/921) ([wyardley](https://github.com/wyardley))
- Changes mock from mocha to rspec-mock [\#920](https://github.com/voxpupuli/puppet-nginx/pull/920) ([petems](https://github.com/petems))
- Adds ability to detect modified nginx for fact [\#913](https://github.com/voxpupuli/puppet-nginx/pull/913) ([petems](https://github.com/petems))
- Revert "Prevent custom fact from complaining when openresty is installed" [\#912](https://github.com/voxpupuli/puppet-nginx/pull/912) ([wyardley](https://github.com/wyardley))
- migrate fixtures to github links [\#910](https://github.com/voxpupuli/puppet-nginx/pull/910) ([bastelfreak](https://github.com/bastelfreak))
- SSL cipher changes \(issue 859\) [\#909](https://github.com/voxpupuli/puppet-nginx/pull/909) ([wyardley](https://github.com/wyardley))
- Prevent custom fact from complaining when openresty is installed [\#908](https://github.com/voxpupuli/puppet-nginx/pull/908) ([wyardley](https://github.com/wyardley))
- update URL in notice [\#907](https://github.com/voxpupuli/puppet-nginx/pull/907) ([wyardley](https://github.com/wyardley))
- 'Require' vhost dir / enable dir in files [\#906](https://github.com/voxpupuli/puppet-nginx/pull/906) ([wyardley](https://github.com/wyardley))
- fix for log\_dir not being honored \(\#895\) [\#904](https://github.com/voxpupuli/puppet-nginx/pull/904) ([wyardley](https://github.com/wyardley))
- switch to voxpup contributer guidelines [\#901](https://github.com/voxpupuli/puppet-nginx/pull/901) ([wyardley](https://github.com/wyardley))
- update of \#812 \(No reasons to manage separate files since confd\_purge is available\) [\#900](https://github.com/voxpupuli/puppet-nginx/pull/900) ([wyardley](https://github.com/wyardley))
- add auth\_http\_header [\#898](https://github.com/voxpupuli/puppet-nginx/pull/898) ([tjikkun](https://github.com/tjikkun))
- try to improve spacing in generated configs \(Issue \#742\) [\#891](https://github.com/voxpupuli/puppet-nginx/pull/891) ([wyardley](https://github.com/wyardley))
- Allow multiple access / error logs in main config and vhosts, other logging changes [\#888](https://github.com/voxpupuli/puppet-nginx/pull/888) ([wyardley](https://github.com/wyardley))
- more test and docs fixes for acceptance tests for CentOS / Passenger [\#886](https://github.com/voxpupuli/puppet-nginx/pull/886) ([wyardley](https://github.com/wyardley))
- Configure acceptance tests on docker on travis [\#885](https://github.com/voxpupuli/puppet-nginx/pull/885) ([3flex](https://github.com/3flex))
- remove unmanaged nodesets [\#884](https://github.com/voxpupuli/puppet-nginx/pull/884) ([3flex](https://github.com/3flex))
- Fix acceptance test failures with newer Beaker versions [\#883](https://github.com/voxpupuli/puppet-nginx/pull/883) ([wyardley](https://github.com/wyardley))
- Add additional config variables with default values \(update of \#693\) [\#881](https://github.com/voxpupuli/puppet-nginx/pull/881) ([wyardley](https://github.com/wyardley))
- add $passenger\_pre\_start variable [\#880](https://github.com/voxpupuli/puppet-nginx/pull/880) ([wyardley](https://github.com/wyardley))
- Add missing stream dirs and create streams from hiera [\#879](https://github.com/voxpupuli/puppet-nginx/pull/879) ([andybotting](https://github.com/andybotting))
- Add confd\_only option [\#878](https://github.com/voxpupuli/puppet-nginx/pull/878) ([wyardley](https://github.com/wyardley))
- add support for passenger on CentOS/RHEL [\#876](https://github.com/voxpupuli/puppet-nginx/pull/876) ([wyardley](https://github.com/wyardley))
- \[keepalive\_requests\] added keepalive\_requests parameter in nginx.conf [\#873](https://github.com/voxpupuli/puppet-nginx/pull/873) ([shoeb751](https://github.com/shoeb751))
- Add option http\_cfg\_prepend [\#870](https://github.com/voxpupuli/puppet-nginx/pull/870) ([abraham1901](https://github.com/abraham1901))
- Expose the uwsgi\_read\_timeout parameter [\#867](https://github.com/voxpupuli/puppet-nginx/pull/867) ([ekohl](https://github.com/ekohl))
- Allow locations with try\_files only [\#834](https://github.com/voxpupuli/puppet-nginx/pull/834) ([FlorianSW](https://github.com/FlorianSW))

## [v0.4.0](https://github.com/voxpupuli/puppet-nginx/tree/v0.4.0) (2016-09-02)

[Full Changelog](https://github.com/voxpupuli/puppet-nginx/compare/v0.3.0...v0.4.0)

**Implemented enhancements:**

- add param proxy\_buffering [\#840](https://github.com/voxpupuli/puppet-nginx/issues/840)
- Add vox pupuli's configuration [\#849](https://github.com/voxpupuli/puppet-nginx/pull/849) ([3flex](https://github.com/3flex))
- Add manage\_service parameter [\#817](https://github.com/voxpupuli/puppet-nginx/pull/817) ([iain-buclaw-sociomantic](https://github.com/iain-buclaw-sociomantic))
- add ssl\_verify\_client parameter [\#798](https://github.com/voxpupuli/puppet-nginx/pull/798) ([rchicoli](https://github.com/rchicoli))
- Add support for multiple 'proxy\_cache\_valid' directives [\#788](https://github.com/voxpupuli/puppet-nginx/pull/788) ([hbog](https://github.com/hbog))

**Fixed bugs:**

- error with $worker\_processes when using parser=future on Puppet 3.7.2 [\#806](https://github.com/voxpupuli/puppet-nginx/issues/806)
- Unable to resolve current fact [\#799](https://github.com/voxpupuli/puppet-nginx/issues/799)
- make fact work on old nginx as well [\#813](https://github.com/voxpupuli/puppet-nginx/pull/813) ([bastelfreak](https://github.com/bastelfreak))

**Closed issues:**

- location\_custom\_cfg only allows 1 rewrite [\#861](https://github.com/voxpupuli/puppet-nginx/issues/861)
- 0.3.0 version on puppet forge and github are different. [\#860](https://github.com/voxpupuli/puppet-nginx/issues/860)
- Resources problem [\#854](https://github.com/voxpupuli/puppet-nginx/issues/854)
- Passenger Enterprise [\#848](https://github.com/voxpupuli/puppet-nginx/issues/848)
- SSL-Only Vhost [\#845](https://github.com/voxpupuli/puppet-nginx/issues/845)
- Tag request [\#843](https://github.com/voxpupuli/puppet-nginx/issues/843)
- Ubuntu 16.04 - signing key error [\#839](https://github.com/voxpupuli/puppet-nginx/issues/839)
- Amazon linux fails to comile [\#837](https://github.com/voxpupuli/puppet-nginx/issues/837)
- Debian package source URL should be overridable.  [\#831](https://github.com/voxpupuli/puppet-nginx/issues/831)
- Debian 8 failure. [\#830](https://github.com/voxpupuli/puppet-nginx/issues/830)
- How to set gzip variables/parameters [\#827](https://github.com/voxpupuli/puppet-nginx/issues/827)
- nginx\_version fact not confined [\#814](https://github.com/voxpupuli/puppet-nginx/issues/814)
- duplicate MIME type "text/html" [\#810](https://github.com/voxpupuli/puppet-nginx/issues/810)
- internal location [\#808](https://github.com/voxpupuli/puppet-nginx/issues/808)
- add\_header doesn't support headers properly [\#803](https://github.com/voxpupuli/puppet-nginx/issues/803)
- concat::fragment $ensure deprecated [\#802](https://github.com/voxpupuli/puppet-nginx/issues/802)
- Version inconsistencies \('v' prepended\) [\#801](https://github.com/voxpupuli/puppet-nginx/issues/801)
- How to prevent variable substitution [\#795](https://github.com/voxpupuli/puppet-nginx/issues/795)
- key and cert are required under SSL [\#793](https://github.com/voxpupuli/puppet-nginx/issues/793)
- WARNING: The $ensure parameter to concat::fragment is deprecated and has no effect [\#776](https://github.com/voxpupuli/puppet-nginx/issues/776)
- Concat 2.0 deprecation warnings  [\#759](https://github.com/voxpupuli/puppet-nginx/issues/759)
- duplicate MIME type "text/html" when starting nginx [\#748](https://github.com/voxpupuli/puppet-nginx/issues/748)
- Setting nginx::config::xxx options in hiera does not work with puppet 4.3 [\#723](https://github.com/voxpupuli/puppet-nginx/issues/723)
- "You cannot collect exported resources without storeconfigs being set" at manifests/resource/upstream.pp:89:5 [\#720](https://github.com/voxpupuli/puppet-nginx/issues/720)
- Redirect http to https. [\#695](https://github.com/voxpupuli/puppet-nginx/issues/695)
- Deprecation warning for parameters [\#564](https://github.com/voxpupuli/puppet-nginx/issues/564)

**Merged pull requests:**

- fix version in README [\#869](https://github.com/voxpupuli/puppet-nginx/pull/869) ([bastelfreak](https://github.com/bastelfreak))
- modulesync 0.12.5 & Release 0.4.0 [\#868](https://github.com/voxpupuli/puppet-nginx/pull/868) ([bastelfreak](https://github.com/bastelfreak))
- update test for \#864 [\#866](https://github.com/voxpupuli/puppet-nginx/pull/866) ([3flex](https://github.com/3flex))
- Make uwsgi\_params non-executable [\#864](https://github.com/voxpupuli/puppet-nginx/pull/864) ([ekohl](https://github.com/ekohl))
- Revert "pin rubocop and rubocop-rspec depending on Ruby version" [\#858](https://github.com/voxpupuli/puppet-nginx/pull/858) ([3flex](https://github.com/3flex))
- pin rubocop and rubocop-rspec depending on Ruby version [\#857](https://github.com/voxpupuli/puppet-nginx/pull/857) ([3flex](https://github.com/3flex))
- add proxy\_buffering parameter to location & vhost [\#856](https://github.com/voxpupuli/puppet-nginx/pull/856) ([igalic](https://github.com/igalic))
- Merge Request \#851 introduced a wrong order of installation [\#852](https://github.com/voxpupuli/puppet-nginx/pull/852) ([Faffnir](https://github.com/Faffnir))
- Conditionally adding the packages if they are not added previously [\#851](https://github.com/voxpupuli/puppet-nginx/pull/851) ([Faffnir](https://github.com/Faffnir))
- gemfile: pin json\_pure to 2.0.1 or lower on ruby 1.x [\#842](https://github.com/voxpupuli/puppet-nginx/pull/842) ([3flex](https://github.com/3flex))
- Add use\_temp\_path into proxy\_cache\_path [\#841](https://github.com/voxpupuli/puppet-nginx/pull/841) ([Slm0n87](https://github.com/Slm0n87))
- fixing issue \#837 [\#838](https://github.com/voxpupuli/puppet-nginx/pull/838) ([ryno75](https://github.com/ryno75))
- Mitigating Httpoxy  [\#835](https://github.com/voxpupuli/puppet-nginx/pull/835) ([marcofl](https://github.com/marcofl))
- Remove storeconfigs warning on puppet apply [\#832](https://github.com/voxpupuli/puppet-nginx/pull/832) ([sorreltree](https://github.com/sorreltree))
- Enhance module metadata [\#826](https://github.com/voxpupuli/puppet-nginx/pull/826) ([3flex](https://github.com/3flex))
- add test for \#813 [\#825](https://github.com/voxpupuli/puppet-nginx/pull/825) ([3flex](https://github.com/3flex))
- travis: enhance the configuration [\#824](https://github.com/voxpupuli/puppet-nginx/pull/824) ([3flex](https://github.com/3flex))
- Fix tests [\#822](https://github.com/voxpupuli/puppet-nginx/pull/822) ([3flex](https://github.com/3flex))
- Add ssl\_session\_tickets and ssl\_session\_ticket\_key parameters [\#821](https://github.com/voxpupuli/puppet-nginx/pull/821) ([iain-buclaw-sociomantic](https://github.com/iain-buclaw-sociomantic))
- Fix location template to not add empty line [\#819](https://github.com/voxpupuli/puppet-nginx/pull/819) ([iain-buclaw-sociomantic](https://github.com/iain-buclaw-sociomantic))
- Confine nginx\_version fact [\#815](https://github.com/voxpupuli/puppet-nginx/pull/815) ([ekingme](https://github.com/ekingme))
- Corrected quickstart documentation [\#811](https://github.com/voxpupuli/puppet-nginx/pull/811) ([frozenfoxx](https://github.com/frozenfoxx))
- Support for proxy\_hide\_header directive. [\#805](https://github.com/voxpupuli/puppet-nginx/pull/805) ([samuelson](https://github.com/samuelson))
- Resolving issue \#803 by adding quotes around the parameters [\#804](https://github.com/voxpupuli/puppet-nginx/pull/804) ([Spechal](https://github.com/Spechal))
- bugfix: convert integer strings to integer [\#778](https://github.com/voxpupuli/puppet-nginx/pull/778) ([vicinus](https://github.com/vicinus))
- Remove SSLv3 as it is insecure [\#775](https://github.com/voxpupuli/puppet-nginx/pull/775) ([ghoneycutt](https://github.com/ghoneycutt))
- Add "satisfy" option to the location section [\#772](https://github.com/voxpupuli/puppet-nginx/pull/772) ([bernhardjt](https://github.com/bernhardjt))
- update catch all vhost example doc [\#770](https://github.com/voxpupuli/puppet-nginx/pull/770) ([kisst](https://github.com/kisst))
- Fixing ruby \<-\> puppet misconfiguration - warning\(\) should be used in… [\#768](https://github.com/voxpupuli/puppet-nginx/pull/768) ([mlipiec](https://github.com/mlipiec))
- Allow removal of gzip\_types from the config [\#765](https://github.com/voxpupuli/puppet-nginx/pull/765) ([3flex](https://github.com/3flex))
- Supress warnings with concat 2.x [\#757](https://github.com/voxpupuli/puppet-nginx/pull/757) ([brandonweeks](https://github.com/brandonweeks))
- Add events accept mutex delay [\#747](https://github.com/voxpupuli/puppet-nginx/pull/747) ([mlrobinson](https://github.com/mlrobinson))

## [v0.3.0](https://github.com/voxpupuli/puppet-nginx/tree/v0.3.0) (2016-02-06)

[Full Changelog](https://github.com/voxpupuli/puppet-nginx/compare/v0.2.7...v0.3.0)

**Implemented enhancements:**

- http -\> https redirection option [\#654](https://github.com/voxpupuli/puppet-nginx/issues/654)
- Multiple proxy\_cache\_path entries [\#637](https://github.com/voxpupuli/puppet-nginx/pull/637) ([jacobmw](https://github.com/jacobmw))

**Fixed bugs:**

- Circuler dependency  [\#656](https://github.com/voxpupuli/puppet-nginx/issues/656)
- upgrade to puppetlabs/apt \>= 2.0.0 [\#646](https://github.com/voxpupuli/puppet-nginx/issues/646)
- Invalid parameter: 'key\_source' Apt::Source\[nginx\] at /etc/puppetlabs/code/modules/nginx/manifests/package/debian.pp:37 [\#629](https://github.com/voxpupuli/puppet-nginx/issues/629)

**Closed issues:**

- Could not retrieve nginx\_version: uninitialized constant Facter::Core [\#758](https://github.com/voxpupuli/puppet-nginx/issues/758)
- README not helping as much as it could to create a reverse proxy [\#751](https://github.com/voxpupuli/puppet-nginx/issues/751)
- no "managed by puppet" comments [\#749](https://github.com/voxpupuli/puppet-nginx/issues/749)
- Unable to connect to Upstart Ubuntu 15.10 [\#734](https://github.com/voxpupuli/puppet-nginx/issues/734)
- manage\_repo =\> false feature is not available [\#731](https://github.com/voxpupuli/puppet-nginx/issues/731)
- Origin of  `invalid parameter "16k"` [\#730](https://github.com/voxpupuli/puppet-nginx/issues/730)
- add\_header for location [\#729](https://github.com/voxpupuli/puppet-nginx/issues/729)
- Circular dependency when setting daemon\_user and super\_user [\#728](https://github.com/voxpupuli/puppet-nginx/issues/728)
- nginx repo key too short [\#714](https://github.com/voxpupuli/puppet-nginx/issues/714)
- Folders beeing created before the package is installed. [\#704](https://github.com/voxpupuli/puppet-nginx/issues/704)
- Puppet 4 support? [\#696](https://github.com/voxpupuli/puppet-nginx/issues/696)
- proxy.conf.erb seems to be missing [\#694](https://github.com/voxpupuli/puppet-nginx/issues/694)
- Support for GeoIP on Debian? [\#691](https://github.com/voxpupuli/puppet-nginx/issues/691)
- http2 support [\#690](https://github.com/voxpupuli/puppet-nginx/issues/690)
- Problem with nginx::resource::vhost and ssl\_cert/ssl\_key path and permissions \(644 for key\) [\#688](https://github.com/voxpupuli/puppet-nginx/issues/688)
- Location ordering [\#685](https://github.com/voxpupuli/puppet-nginx/issues/685)
- Error: Comparison of: String \< Integer, is not possible [\#684](https://github.com/voxpupuli/puppet-nginx/issues/684)
- Why worker\_processes isn't set at processorcount by default? [\#679](https://github.com/voxpupuli/puppet-nginx/issues/679)
- warning/notice about hiera? [\#677](https://github.com/voxpupuli/puppet-nginx/issues/677)
- fastcgi.erb doesn't include rewrite\_rules. Why? [\#674](https://github.com/voxpupuli/puppet-nginx/issues/674)
- upstream::member: ensure? [\#672](https://github.com/voxpupuli/puppet-nginx/issues/672)
- Hiera changes aren't picked up [\#671](https://github.com/voxpupuli/puppet-nginx/issues/671)
- Wildcard domain [\#668](https://github.com/voxpupuli/puppet-nginx/issues/668)
- Hiera Variables and return 301. [\#665](https://github.com/voxpupuli/puppet-nginx/issues/665)
- Misinterpretation of puppet-module-data [\#663](https://github.com/voxpupuli/puppet-nginx/issues/663)
- Deprecation warning when adding worker\_processes through hiera [\#655](https://github.com/voxpupuli/puppet-nginx/issues/655)
- Invalid parameter options on Apt\_key\[Add key: 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62 from Apt::Source nginx\] [\#650](https://github.com/voxpupuli/puppet-nginx/issues/650)

**Merged pull requests:**

- travis: enable bundler caching in builds [\#764](https://github.com/voxpupuli/puppet-nginx/pull/764) ([3flex](https://github.com/3flex))
- travis: test with strict\_variables on puppet 4 [\#763](https://github.com/voxpupuli/puppet-nginx/pull/763) ([3flex](https://github.com/3flex))
- nginx version fact compatibility with Facter 1.7 [\#762](https://github.com/voxpupuli/puppet-nginx/pull/762) ([alexharv074](https://github.com/alexharv074))
- removed invalid resource parameters from doc [\#761](https://github.com/voxpupuli/puppet-nginx/pull/761) ([ericsysmin](https://github.com/ericsysmin))
- Fix a typo in location\_custom\_cfg\_append description. [\#756](https://github.com/voxpupuli/puppet-nginx/pull/756) ([xa4a](https://github.com/xa4a))
- Add nginx\_version fact [\#753](https://github.com/voxpupuli/puppet-nginx/pull/753) ([jyaworski](https://github.com/jyaworski))
- Issue 751 Add an example for a simple reverse proxy to the README [\#752](https://github.com/voxpupuli/puppet-nginx/pull/752) ([alexharv074](https://github.com/alexharv074))
- Issue\_749  Add 'managed by puppet' to config files [\#750](https://github.com/voxpupuli/puppet-nginx/pull/750) ([alexharv074](https://github.com/alexharv074))
- Remove extra white space [\#744](https://github.com/voxpupuli/puppet-nginx/pull/744) ([gerases](https://github.com/gerases))
- Added locations paramater to use it in hiera. [\#738](https://github.com/voxpupuli/puppet-nginx/pull/738) ([jkroepke](https://github.com/jkroepke))
- restart replaced with reload in service\_spec.rb file [\#725](https://github.com/voxpupuli/puppet-nginx/pull/725) ([pallavjosh](https://github.com/pallavjosh))
- improved location ordering [\#724](https://github.com/voxpupuli/puppet-nginx/pull/724) ([vicinus](https://github.com/vicinus))
- Deprecate $proxy\_conf\_template [\#715](https://github.com/voxpupuli/puppet-nginx/pull/715) ([3flex](https://github.com/3flex))
- Add parameter to allow setting error\_log severity level [\#709](https://github.com/voxpupuli/puppet-nginx/pull/709) ([Phil-Friderici](https://github.com/Phil-Friderici))
- Add unix socket for listening. [\#707](https://github.com/voxpupuli/puppet-nginx/pull/707) ([werekraken](https://github.com/werekraken))
- Ensure isn't being respected on locations. [\#705](https://github.com/voxpupuli/puppet-nginx/pull/705) ([kwolf](https://github.com/kwolf))
- Http2 support [\#703](https://github.com/voxpupuli/puppet-nginx/pull/703) ([jhooyberghs](https://github.com/jhooyberghs))
- Replaced restart by reload [\#702](https://github.com/voxpupuli/puppet-nginx/pull/702) ([matfra](https://github.com/matfra))
- Update vhost proxy\_set\_header defaults to match location [\#700](https://github.com/voxpupuli/puppet-nginx/pull/700) ([alext](https://github.com/alext))
- Adding a QuickStart Guide to the NGINX Module [\#699](https://github.com/voxpupuli/puppet-nginx/pull/699) ([chadothompson](https://github.com/chadothompson))
- Adding support for stream configuration [\#697](https://github.com/voxpupuli/puppet-nginx/pull/697) ([hopperd](https://github.com/hopperd))
- Convert $priority to integer before comparison [\#689](https://github.com/voxpupuli/puppet-nginx/pull/689) ([erikanderson](https://github.com/erikanderson))
- iterate server\_name when rewrite\_www\_to\_non\_www is used [\#683](https://github.com/voxpupuli/puppet-nginx/pull/683) ([kronos-pbrideau](https://github.com/kronos-pbrideau))
- adding a max\_fails parameter to upstream member\[s\] [\#675](https://github.com/voxpupuli/puppet-nginx/pull/675) ([vigx](https://github.com/vigx))
- Add 'ensure' parameter to resource::upstream::member. [\#673](https://github.com/voxpupuli/puppet-nginx/pull/673) ([kwolf](https://github.com/kwolf))
- Update non-hiera usage \(see \#536\) [\#669](https://github.com/voxpupuli/puppet-nginx/pull/669) ([Hufschmidt](https://github.com/Hufschmidt))
- Don't qualified call to defined resource type [\#666](https://github.com/voxpupuli/puppet-nginx/pull/666) ([PierreR](https://github.com/PierreR))
- vhost: add ssl\_buffer\_size to SSL config [\#660](https://github.com/voxpupuli/puppet-nginx/pull/660) ([3flex](https://github.com/3flex))
- add remaining gzip directives [\#659](https://github.com/voxpupuli/puppet-nginx/pull/659) ([3flex](https://github.com/3flex))
- sort add\_header values for ssl vhost [\#658](https://github.com/voxpupuli/puppet-nginx/pull/658) ([cgroschupp](https://github.com/cgroschupp))
- update default SSL ciphers [\#652](https://github.com/voxpupuli/puppet-nginx/pull/652) ([pulecp](https://github.com/pulecp))

## [v0.2.7](https://github.com/voxpupuli/puppet-nginx/tree/v0.2.7) (2015-06-18)

[Full Changelog](https://github.com/voxpupuli/puppet-nginx/compare/v0.2.6...v0.2.7)

**Implemented enhancements:**

- SSL Self signed cert [\#630](https://github.com/voxpupuli/puppet-nginx/issues/630)
- Latest version no longer works on DragonFlyBSD [\#619](https://github.com/voxpupuli/puppet-nginx/issues/619)
- Support puppetlabs-apt 2.0.0 [\#611](https://github.com/voxpupuli/puppet-nginx/issues/611)
- Unable to set auth\_basic for "alias" location type [\#600](https://github.com/voxpupuli/puppet-nginx/issues/600)
- Storing SSH Keys and Certs in Hiera [\#286](https://github.com/voxpupuli/puppet-nginx/issues/286)
- fastcgi location does not support auth\_basic [\#260](https://github.com/voxpupuli/puppet-nginx/issues/260)
- Vhost and loation proxy\_cache\_key and proxy\_cache\_use\_stale [\#636](https://github.com/voxpupuli/puppet-nginx/pull/636) ([jacobmw](https://github.com/jacobmw))
- Create directory for log files [\#635](https://github.com/voxpupuli/puppet-nginx/pull/635) ([geoffgarside](https://github.com/geoffgarside))
- SSL updates [\#623](https://github.com/voxpupuli/puppet-nginx/pull/623) ([3flex](https://github.com/3flex))
- travis: test on Puppet 4 for real [\#613](https://github.com/voxpupuli/puppet-nginx/pull/613) ([3flex](https://github.com/3flex))
- package/debian: support puppetlabs-apt 2.0.0 [\#612](https://github.com/voxpupuli/puppet-nginx/pull/612) ([3flex](https://github.com/3flex))
- Switch acceptance tests to Beaker [\#607](https://github.com/voxpupuli/puppet-nginx/pull/607) ([3flex](https://github.com/3flex))
- Add uwsgi support [\#398](https://github.com/voxpupuli/puppet-nginx/pull/398) ([mvintila](https://github.com/mvintila))

**Fixed bugs:**

- Circular dependency in 0.2.3 [\#609](https://github.com/voxpupuli/puppet-nginx/issues/609)
- redundant "maintenance" code applied to every vhost [\#602](https://github.com/voxpupuli/puppet-nginx/issues/602)
- Can't have more than 1 password protected location [\#572](https://github.com/voxpupuli/puppet-nginx/issues/572)
- type reference for create\_resources in init.pp using top level namespace causing catalog to fail to compile [\#550](https://github.com/voxpupuli/puppet-nginx/issues/550)
- Circular Dependency Error When referenced from another module [\#244](https://github.com/voxpupuli/puppet-nginx/issues/244)
- Require base folder for resources [\#624](https://github.com/voxpupuli/puppet-nginx/pull/624) ([Tombar](https://github.com/Tombar))
- location: remove the auth\_basic\_user\_file resource [\#608](https://github.com/voxpupuli/puppet-nginx/pull/608) ([3flex](https://github.com/3flex))
- Include ssl settings in rewrite\_www server. [\#548](https://github.com/voxpupuli/puppet-nginx/pull/548) ([joehillen](https://github.com/joehillen))
- Prevent missing resource errors if custom configuration is used without default location [\#545](https://github.com/voxpupuli/puppet-nginx/pull/545) ([SteveMaddison](https://github.com/SteveMaddison))

**Closed issues:**

- ssl\_cert =\> 'puppet:///modules/sslkey/wildcard\_mydomain.crt' doesn't work after upgrade [\#638](https://github.com/voxpupuli/puppet-nginx/issues/638)
- Unable to validate module on servers not using it [\#631](https://github.com/voxpupuli/puppet-nginx/issues/631)
- Support Debian 8 [\#620](https://github.com/voxpupuli/puppet-nginx/issues/620)
- 'undef' from left operand of 'in' expression is not a string at /etc/puppet/modules/nginx/manifests/params.pp:23 [\#601](https://github.com/voxpupuli/puppet-nginx/issues/601)
- \[WIP\] Improve SSL support [\#599](https://github.com/voxpupuli/puppet-nginx/issues/599)
- ssl vhost gives error  [\#585](https://github.com/voxpupuli/puppet-nginx/issues/585)
- class ::nginx::config has not been evaluated [\#580](https://github.com/voxpupuli/puppet-nginx/issues/580)
- vagrant vhost files [\#577](https://github.com/voxpupuli/puppet-nginx/issues/577)
- How to set document root in server block using hiera? [\#576](https://github.com/voxpupuli/puppet-nginx/issues/576)
- Configure passenger through hiera. [\#568](https://github.com/voxpupuli/puppet-nginx/issues/568)
- location\_custom\_cfg not processing in template [\#567](https://github.com/voxpupuli/puppet-nginx/issues/567)
- SSL issue with rewrite\_www\_to\_non\_www parameter [\#542](https://github.com/voxpupuli/puppet-nginx/issues/542)
- location\_custom\_cfg\_append keeps on refreshing nginx service every puppet run. [\#503](https://github.com/voxpupuli/puppet-nginx/issues/503)
- Setting up nginx cache, not getting the expected result. [\#424](https://github.com/voxpupuli/puppet-nginx/issues/424)
- Sendfile not fully configurable  [\#422](https://github.com/voxpupuli/puppet-nginx/issues/422)
- ssl certificates [\#404](https://github.com/voxpupuli/puppet-nginx/issues/404)
- More thorough documentation [\#401](https://github.com/voxpupuli/puppet-nginx/issues/401)
- SSL certificate not found [\#397](https://github.com/voxpupuli/puppet-nginx/issues/397)
- vhost: $rewrite\_www\_to\_non\_www [\#381](https://github.com/voxpupuli/puppet-nginx/issues/381)
- Support internal locations [\#340](https://github.com/voxpupuli/puppet-nginx/issues/340)
- vhost configuration, www\_root and default location [\#317](https://github.com/voxpupuli/puppet-nginx/issues/317)
- Invalid Relationship File [\#299](https://github.com/voxpupuli/puppet-nginx/issues/299)
- Add rewrite with if clause to puppet [\#279](https://github.com/voxpupuli/puppet-nginx/issues/279)
- Allow to use multiple locations in vhost [\#189](https://github.com/voxpupuli/puppet-nginx/issues/189)
- SSL Cert/Key Template [\#126](https://github.com/voxpupuli/puppet-nginx/issues/126)
- Subdir for ssl certs [\#80](https://github.com/voxpupuli/puppet-nginx/issues/80)

**Merged pull requests:**

- Revert "Require base folder for resources" [\#643](https://github.com/voxpupuli/puppet-nginx/pull/643) ([3flex](https://github.com/3flex))
- Allow better control of http level proxy directives [\#642](https://github.com/voxpupuli/puppet-nginx/pull/642) ([jd-daniels](https://github.com/jd-daniels))
- spec: update upstream\_spec for puppetlabs-concat 2 [\#632](https://github.com/voxpupuli/puppet-nginx/pull/632) ([3flex](https://github.com/3flex))
- spec: add some more nginx.conf tests [\#628](https://github.com/voxpupuli/puppet-nginx/pull/628) ([3flex](https://github.com/3flex))
- travis: drop ruby 1.8.7 tests [\#627](https://github.com/voxpupuli/puppet-nginx/pull/627) ([3flex](https://github.com/3flex))
- Fail on lint warnings [\#626](https://github.com/voxpupuli/puppet-nginx/pull/626) ([3flex](https://github.com/3flex))
- remove ensure from concat::fragment as its deprecated [\#625](https://github.com/voxpupuli/puppet-nginx/pull/625) ([Tombar](https://github.com/Tombar))
- Add support for Debian 8 [\#621](https://github.com/voxpupuli/puppet-nginx/pull/621) ([3flex](https://github.com/3flex))
- Add passenger\_set\_header and passenger\_env\_var parameters for Passenger 5.0+ [\#618](https://github.com/voxpupuli/puppet-nginx/pull/618) ([mmarod](https://github.com/mmarod))
- fix docs [\#616](https://github.com/voxpupuli/puppet-nginx/pull/616) ([cofyc](https://github.com/cofyc))
- vhost: simplify maintenance variable code [\#606](https://github.com/voxpupuli/puppet-nginx/pull/606) ([3flex](https://github.com/3flex))
- location: move auth\_basic directives to header [\#605](https://github.com/voxpupuli/puppet-nginx/pull/605) ([3flex](https://github.com/3flex))
- init: fix create\_resources declarations for old puppet versions [\#604](https://github.com/voxpupuli/puppet-nginx/pull/604) ([3flex](https://github.com/3flex))
- metadata: add Puppet version compatibility [\#598](https://github.com/voxpupuli/puppet-nginx/pull/598) ([3flex](https://github.com/3flex))
- gitattributes: add file so all \*.pp is recognized as Puppet on Github [\#597](https://github.com/voxpupuli/puppet-nginx/pull/597) ([3flex](https://github.com/3flex))
- package/redhat: correct dependency on package [\#595](https://github.com/voxpupuli/puppet-nginx/pull/595) ([3flex](https://github.com/3flex))
- readme: add Puppet Forge version badge [\#594](https://github.com/voxpupuli/puppet-nginx/pull/594) ([3flex](https://github.com/3flex))
- config: refined worker\_processes validation [\#590](https://github.com/voxpupuli/puppet-nginx/pull/590) ([3flex](https://github.com/3flex))
- Fixing default location to use specified index files. [\#530](https://github.com/voxpupuli/puppet-nginx/pull/530) ([scottsb](https://github.com/scottsb))

## [v0.2.6](https://github.com/voxpupuli/puppet-nginx/tree/v0.2.6) (2015-04-07)

[Full Changelog](https://github.com/voxpupuli/puppet-nginx/compare/v0.2.5...v0.2.6)

**Closed issues:**

- Invalid parameter flags [\#586](https://github.com/voxpupuli/puppet-nginx/issues/586)

**Merged pull requests:**

- Fix typo [\#593](https://github.com/voxpupuli/puppet-nginx/pull/593) ([mcanevet](https://github.com/mcanevet))

## [v0.2.5](https://github.com/voxpupuli/puppet-nginx/tree/v0.2.5) (2015-04-02)

[Full Changelog](https://github.com/voxpupuli/puppet-nginx/compare/v0.2.4...v0.2.5)

**Closed issues:**

- Problem adding if blocks inside a location using location\_cfg\_append/prepend [\#308](https://github.com/voxpupuli/puppet-nginx/issues/308)

**Merged pull requests:**

- Don't allow failures when using the future parser [\#588](https://github.com/voxpupuli/puppet-nginx/pull/588) ([3flex](https://github.com/3flex))
- Rspec puppet 2 [\#587](https://github.com/voxpupuli/puppet-nginx/pull/587) ([3flex](https://github.com/3flex))
- feat \(maintenance\): allow to specify maintenance behavior. Add docs. [\#584](https://github.com/voxpupuli/puppet-nginx/pull/584) ([brunoleon](https://github.com/brunoleon))
- Fix possibility to set package name [\#571](https://github.com/voxpupuli/puppet-nginx/pull/571) ([globin](https://github.com/globin))
- Flags parameter supported only on OpenBSD [\#569](https://github.com/voxpupuli/puppet-nginx/pull/569) ([Zophar78](https://github.com/Zophar78))

## [v0.2.4](https://github.com/voxpupuli/puppet-nginx/tree/v0.2.4) (2015-03-24)

[Full Changelog](https://github.com/voxpupuli/puppet-nginx/compare/v0.2.3...v0.2.4)

**Merged pull requests:**

- Changing apt key to 40 characters to support new apt module [\#583](https://github.com/voxpupuli/puppet-nginx/pull/583) ([errygg](https://github.com/errygg))

## [v0.2.3](https://github.com/voxpupuli/puppet-nginx/tree/v0.2.3) (2015-03-23)

[Full Changelog](https://github.com/voxpupuli/puppet-nginx/compare/v0.2.2...v0.2.3)

**Closed issues:**

- Support ssl\_verify\_client [\#581](https://github.com/voxpupuli/puppet-nginx/issues/581)
- Example hiera configuration doesn't work [\#558](https://github.com/voxpupuli/puppet-nginx/issues/558)
- Hiera documentation bug [\#555](https://github.com/voxpupuli/puppet-nginx/issues/555)
- new tag? [\#547](https://github.com/voxpupuli/puppet-nginx/issues/547)
- Symlink happening after service refresh [\#541](https://github.com/voxpupuli/puppet-nginx/issues/541)

**Merged pull requests:**

- Support ssl client verify [\#582](https://github.com/voxpupuli/puppet-nginx/pull/582) ([jamescarr](https://github.com/jamescarr))
- apt::key: puppetlabs-apt check now the full GPG fingerprints. [\#579](https://github.com/voxpupuli/puppet-nginx/pull/579) ([sbadia](https://github.com/sbadia))
- feat: add an easy maintenance page support [\#578](https://github.com/voxpupuli/puppet-nginx/pull/578) ([brunoleon](https://github.com/brunoleon))
- Prepend to the nginx config block [\#574](https://github.com/voxpupuli/puppet-nginx/pull/574) ([prachetasp](https://github.com/prachetasp))
- Revert "changed $::operatingsystemmajrelease to $::lsbmajdistrelease for... [\#565](https://github.com/voxpupuli/puppet-nginx/pull/565) ([jfryman](https://github.com/jfryman))
- Sort fastcgi params to have stable ordering [\#561](https://github.com/voxpupuli/puppet-nginx/pull/561) ([mlafeldt](https://github.com/mlafeldt))
- changed $::operatingsystemmajrelease to $::lsbmajdistrelease for Debian [\#560](https://github.com/voxpupuli/puppet-nginx/pull/560) ([janschumann](https://github.com/janschumann))
- README: fix hiera nginx\_locations example [\#559](https://github.com/voxpupuli/puppet-nginx/pull/559) ([3flex](https://github.com/3flex))
- Set up relationships for nginx::config even when overridden [\#557](https://github.com/voxpupuli/puppet-nginx/pull/557) ([radford](https://github.com/radford))
- closes \#541 \(maybe: needs user feedback\) [\#553](https://github.com/voxpupuli/puppet-nginx/pull/553) ([steakknife](https://github.com/steakknife))
- Allow to use OpenBSD specific service\_flags and package\_flavors. [\#552](https://github.com/voxpupuli/puppet-nginx/pull/552) ([buzzdeee](https://github.com/buzzdeee))
- sort add\_header values for vhost [\#551](https://github.com/voxpupuli/puppet-nginx/pull/551) ([sbaryakov](https://github.com/sbaryakov))
- do www-rewrite with params [\#549](https://github.com/voxpupuli/puppet-nginx/pull/549) ([paschdan](https://github.com/paschdan))
- allow listen\_ip and ipv6\_listen\_ip to contain a String or Array [\#546](https://github.com/voxpupuli/puppet-nginx/pull/546) ([b4ldr](https://github.com/b4ldr))

## [v0.2.2](https://github.com/voxpupuli/puppet-nginx/tree/v0.2.2) (2015-01-19)

[Full Changelog](https://github.com/voxpupuli/puppet-nginx/compare/0.2.1...v0.2.2)

**Closed issues:**

- "worker\_connections must be an integer" error [\#537](https://github.com/voxpupuli/puppet-nginx/issues/537)
- Stub\_status [\#523](https://github.com/voxpupuli/puppet-nginx/issues/523)
- Could not find dependent Exec\[concat\_/etc/nginx/sites-available/connect.conf\] [\#514](https://github.com/voxpupuli/puppet-nginx/issues/514)
- Proper integer quoting to resolve futureparser issues [\#512](https://github.com/voxpupuli/puppet-nginx/issues/512)
- Missing semicolons in vhost location footer [\#498](https://github.com/voxpupuli/puppet-nginx/issues/498)
- Add canary checks for Hiera lookup [\#463](https://github.com/voxpupuli/puppet-nginx/issues/463)
- Add support for mainline version [\#450](https://github.com/voxpupuli/puppet-nginx/issues/450)
- unknown directive "passenger\_root" in /etc/nginx/nginx.conf [\#427](https://github.com/voxpupuli/puppet-nginx/issues/427)
- Add extras packages? [\#341](https://github.com/voxpupuli/puppet-nginx/issues/341)

**Merged pull requests:**

- metadata: require puppetlabs-stdlib 4.2.0 and up [\#539](https://github.com/voxpupuli/puppet-nginx/pull/539) ([3flex](https://github.com/3flex))
- Configurable service name [\#534](https://github.com/voxpupuli/puppet-nginx/pull/534) ([3flex](https://github.com/3flex))
- Gemfile: pin rspec-puppet to 1.x [\#533](https://github.com/voxpupuli/puppet-nginx/pull/533) ([3flex](https://github.com/3flex))
- Sort sub hash keys to have a stable ordering [\#532](https://github.com/voxpupuli/puppet-nginx/pull/532) ([mbornoz](https://github.com/mbornoz))
- Allow disabling proxy\_http\_version directive [\#531](https://github.com/voxpupuli/puppet-nginx/pull/531) ([ckaenzig](https://github.com/ckaenzig))
- Update hiera.md [\#528](https://github.com/voxpupuli/puppet-nginx/pull/528) ([skoblenick](https://github.com/skoblenick))
- Allow arrays values in http\_cfg\_append [\#527](https://github.com/voxpupuli/puppet-nginx/pull/527) ([ese](https://github.com/ese))
- moves rewrite\_rules to location\_header [\#526](https://github.com/voxpupuli/puppet-nginx/pull/526) ([paschdan](https://github.com/paschdan))
- Notify the service after purging configuration files [\#525](https://github.com/voxpupuli/puppet-nginx/pull/525) ([radford](https://github.com/radford))
- travis: enable container-based builds [\#524](https://github.com/voxpupuli/puppet-nginx/pull/524) ([3flex](https://github.com/3flex))
- Update puppet-lint config [\#522](https://github.com/voxpupuli/puppet-nginx/pull/522) ([3flex](https://github.com/3flex))
- don't ignore lint errors [\#521](https://github.com/voxpupuli/puppet-nginx/pull/521) ([3flex](https://github.com/3flex))
- metadata: add operatingsystem\_support [\#520](https://github.com/voxpupuli/puppet-nginx/pull/520) ([3flex](https://github.com/3flex))
- Clean up package classes, allow installing mainline upstream packages [\#519](https://github.com/voxpupuli/puppet-nginx/pull/519) ([3flex](https://github.com/3flex))
- location: fix ensure [\#517](https://github.com/voxpupuli/puppet-nginx/pull/517) ([radford](https://github.com/radford))
- init: pass parameters when declaring nginx::service [\#516](https://github.com/voxpupuli/puppet-nginx/pull/516) ([3flex](https://github.com/3flex))
- fix a future parser failure introduced by \#510 [\#513](https://github.com/voxpupuli/puppet-nginx/pull/513) ([3flex](https://github.com/3flex))
- Fully qualify classes, defines and variables [\#510](https://github.com/voxpupuli/puppet-nginx/pull/510) ([3flex](https://github.com/3flex))
- Add initial OpenBSD support. [\#507](https://github.com/voxpupuli/puppet-nginx/pull/507) ([frenkel](https://github.com/frenkel))
- Impossible to set proxy\_set\_header for default location [\#467](https://github.com/voxpupuli/puppet-nginx/pull/467) ([invliD](https://github.com/invliD))

## [0.2.1](https://github.com/voxpupuli/puppet-nginx/tree/0.2.1) (2014-11-24)

[Full Changelog](https://github.com/voxpupuli/puppet-nginx/compare/0.2.0...0.2.1)

**Closed issues:**

- proxy\_headers\_hash\_bucket\_size being validated as a string? [\#505](https://github.com/voxpupuli/puppet-nginx/issues/505)
- CentOS 6.6 Nginx and SELinux Issue [\#496](https://github.com/voxpupuli/puppet-nginx/issues/496)
- Having difficulty understanding how to use hiera to replace params.pp [\#494](https://github.com/voxpupuli/puppet-nginx/issues/494)
- Cannot get new Hiera module\_data to work correctly [\#484](https://github.com/voxpupuli/puppet-nginx/issues/484)
- Start tracking actual versions w/ Semantic Versioning [\#64](https://github.com/voxpupuli/puppet-nginx/issues/64)
- Refactor to params pattern [\#62](https://github.com/voxpupuli/puppet-nginx/issues/62)

**Merged pull requests:**

- Adjust integers to strings. [\#509](https://github.com/voxpupuli/puppet-nginx/pull/509) ([jfryman](https://github.com/jfryman))
- Deprecated comment. [\#508](https://github.com/voxpupuli/puppet-nginx/pull/508) ([PierreR](https://github.com/PierreR))

## [0.2.0](https://github.com/voxpupuli/puppet-nginx/tree/0.2.0) (2014-11-22)

[Full Changelog](https://github.com/voxpupuli/puppet-nginx/compare/0.1.1...0.2.0)

**Closed issues:**

- operatingsystemmajrelease doesn't exist on Ubuntu with facter \< 2.2.0 [\#497](https://github.com/voxpupuli/puppet-nginx/issues/497)
- Default to running? [\#488](https://github.com/voxpupuli/puppet-nginx/issues/488)
- Remove support for SSLv3 due to Poodle Attack [\#478](https://github.com/voxpupuli/puppet-nginx/issues/478)
- rewrite\_to\_https doesn't use different SSL port numbers correctly \(fix included\) [\#477](https://github.com/voxpupuli/puppet-nginx/issues/477)
- templates/vhost/vhost\_header.erb last line issue [\#474](https://github.com/voxpupuli/puppet-nginx/issues/474)
- worker\_connections must be integer since 'Introducing Puppet Module Tool' [\#472](https://github.com/voxpupuli/puppet-nginx/issues/472)
- \(maint\) metadata.json has wrong license [\#466](https://github.com/voxpupuli/puppet-nginx/issues/466)
- Upstream requires nginx since 0.0.10 [\#458](https://github.com/voxpupuli/puppet-nginx/issues/458)
- Centos 7 support? [\#445](https://github.com/voxpupuli/puppet-nginx/issues/445)

**Merged pull requests:**

- fix my name [\#504](https://github.com/voxpupuli/puppet-nginx/pull/504) ([ripienaar](https://github.com/ripienaar))
- Reorganise whitespace in the vhost header and location header/footer. [\#502](https://github.com/voxpupuli/puppet-nginx/pull/502) ([cewood](https://github.com/cewood))
- Rip back out puppet-module-data [\#501](https://github.com/voxpupuli/puppet-nginx/pull/501) ([jfryman](https://github.com/jfryman))
- vhost: add a blank line at the end of the header template [\#490](https://github.com/voxpupuli/puppet-nginx/pull/490) ([vincentbernat](https://github.com/vincentbernat))
- Fix tabs and hash rocket alignment. [\#489](https://github.com/voxpupuli/puppet-nginx/pull/489) ([actown](https://github.com/actown))
- Update default SSL Ciphers [\#485](https://github.com/voxpupuli/puppet-nginx/pull/485) ([jfryman](https://github.com/jfryman))
- Use stronger ciphers [\#483](https://github.com/voxpupuli/puppet-nginx/pull/483) ([ghoneycutt](https://github.com/ghoneycutt))
- Remove the SSLv3 by default in the vhost resource. [\#480](https://github.com/voxpupuli/puppet-nginx/pull/480) ([actown](https://github.com/actown))
- Allow internal-only location resources [\#464](https://github.com/voxpupuli/puppet-nginx/pull/464) ([danieldreier](https://github.com/danieldreier))

## [0.1.1](https://github.com/voxpupuli/puppet-nginx/tree/0.1.1) (2014-09-25)

[Full Changelog](https://github.com/voxpupuli/puppet-nginx/compare/0.1.0...0.1.1)

**Closed issues:**

- $worker\_connections must be an integer [\#460](https://github.com/voxpupuli/puppet-nginx/issues/460)

**Merged pull requests:**

- Add instructions on bootstrapping puppet-module-data [\#461](https://github.com/voxpupuli/puppet-nginx/pull/461) ([jfryman](https://github.com/jfryman))

## [0.1.0](https://github.com/voxpupuli/puppet-nginx/tree/0.1.0) (2014-09-24)

[Full Changelog](https://github.com/voxpupuli/puppet-nginx/compare/v0.0.10...0.1.0)

**Closed issues:**

- Cannot create a location reference without a www\_root, proxy, location\_alias, fastcgi, stub\_status, or location\_custom\_cfg [\#446](https://github.com/voxpupuli/puppet-nginx/issues/446)
- \(maint\) add copyright owner to license file [\#441](https://github.com/voxpupuli/puppet-nginx/issues/441)
- Invalid parameter ensure on upstream [\#439](https://github.com/voxpupuli/puppet-nginx/issues/439)
- downgrade concat dependency for wider support [\#435](https://github.com/voxpupuli/puppet-nginx/issues/435)
- How to install nginx modules? [\#428](https://github.com/voxpupuli/puppet-nginx/issues/428)
- Hiera does not merge correctly [\#426](https://github.com/voxpupuli/puppet-nginx/issues/426)
- upstream\_cfg\_prepend not working for hash keys without values \(ip\_hash, least\_conn\) [\#425](https://github.com/voxpupuli/puppet-nginx/issues/425)
- \(maint\) Missing metadata.json [\#419](https://github.com/voxpupuli/puppet-nginx/issues/419)
- CentOS 7 Support [\#418](https://github.com/voxpupuli/puppet-nginx/issues/418)
- Nginx vhost with php support [\#416](https://github.com/voxpupuli/puppet-nginx/issues/416)
- Adding new vhosts throws errors [\#415](https://github.com/voxpupuli/puppet-nginx/issues/415)
- Documentation Error [\#405](https://github.com/voxpupuli/puppet-nginx/issues/405)
- puppet lint [\#400](https://github.com/voxpupuli/puppet-nginx/issues/400)
- nx\_daemon\_user [\#399](https://github.com/voxpupuli/puppet-nginx/issues/399)
- proxy\_hide\_header parameter [\#394](https://github.com/voxpupuli/puppet-nginx/issues/394)
- Fastcgi Params [\#389](https://github.com/voxpupuli/puppet-nginx/issues/389)
- Option to create directory of locations and vhosts [\#385](https://github.com/voxpupuli/puppet-nginx/issues/385)
- Release New Version [\#384](https://github.com/voxpupuli/puppet-nginx/issues/384)
- $location\_custom\_cfg issues [\#372](https://github.com/voxpupuli/puppet-nginx/issues/372)
- offer a way to remove default.conf from /etc/nginx/conf.d [\#333](https://github.com/voxpupuli/puppet-nginx/issues/333)
- regsubst error in resource/location.pp with future parser [\#322](https://github.com/voxpupuli/puppet-nginx/issues/322)
- `nginx::params::nx\_multi\_accept` is not set. [\#313](https://github.com/voxpupuli/puppet-nginx/issues/313)
- `nginx::params::nx\_events\_use` is not set. [\#312](https://github.com/voxpupuli/puppet-nginx/issues/312)
- Relax or improve the syntax check on proxy\_cache\_levels [\#294](https://github.com/voxpupuli/puppet-nginx/issues/294)

**Merged pull requests:**

- Guard against undef [\#459](https://github.com/voxpupuli/puppet-nginx/pull/459) ([pradermecker](https://github.com/pradermecker))
- Fix to detect the major release version for redhat/centos 7 [\#454](https://github.com/voxpupuli/puppet-nginx/pull/454) ([francis826](https://github.com/francis826))
- Introducing Puppet Module Data [\#453](https://github.com/voxpupuli/puppet-nginx/pull/453) ([jfryman](https://github.com/jfryman))
- \(maint\) switch from Modulefile to metadata.json [\#452](https://github.com/voxpupuli/puppet-nginx/pull/452) ([3flex](https://github.com/3flex))
- cleanup whitespace and key/value alignment in config files [\#443](https://github.com/voxpupuli/puppet-nginx/pull/443) ([rabbitt](https://github.com/rabbitt))
- Re-add Gentoo support [\#440](https://github.com/voxpupuli/puppet-nginx/pull/440) ([jrieger](https://github.com/jrieger))
- Test with future parser [\#438](https://github.com/voxpupuli/puppet-nginx/pull/438) ([3flex](https://github.com/3flex))
- Removed proxy\_cache\_valid as default when using proxy\_cache option [\#434](https://github.com/voxpupuli/puppet-nginx/pull/434) ([pablokbs](https://github.com/pablokbs))
- Update maintainers in the Repository [\#420](https://github.com/voxpupuli/puppet-nginx/pull/420) ([jfryman](https://github.com/jfryman))
- Enable streaming [\#413](https://github.com/voxpupuli/puppet-nginx/pull/413) ([zshahan](https://github.com/zshahan))
- Add Red Hat/CentOS 7 support [\#412](https://github.com/voxpupuli/puppet-nginx/pull/412) ([3flex](https://github.com/3flex))
- Fixed documentation in resource map [\#410](https://github.com/voxpupuli/puppet-nginx/pull/410) ([jg-development](https://github.com/jg-development))
- Fix deprecated variable access warning [\#406](https://github.com/voxpupuli/puppet-nginx/pull/406) ([corycomer](https://github.com/corycomer))
- Added configuration of custom fastcgi\_params \[fixes \#389\] [\#396](https://github.com/voxpupuli/puppet-nginx/pull/396) ([chaosmail](https://github.com/chaosmail))
- Align index to the rest of template contents [\#386](https://github.com/voxpupuli/puppet-nginx/pull/386) ([xaque208](https://github.com/xaque208))
- Correct validation of {proxy,fastcgi}\_cache\_levels [\#382](https://github.com/voxpupuli/puppet-nginx/pull/382) ([3flex](https://github.com/3flex))
- Convert specs to RSpec 2.99.1 syntax with Transpec [\#378](https://github.com/voxpupuli/puppet-nginx/pull/378) ([3flex](https://github.com/3flex))
- Improve test suite \(Travis updates, librarian-puppet removal, better utilize puppet-lint\) [\#377](https://github.com/voxpupuli/puppet-nginx/pull/377) ([3flex](https://github.com/3flex))

## [v0.0.10](https://github.com/voxpupuli/puppet-nginx/tree/v0.0.10) (2014-08-13)

[Full Changelog](https://github.com/voxpupuli/puppet-nginx/compare/v0.0.9...v0.0.10)

**Closed issues:**

- concat 1.1.0 dependency [\#393](https://github.com/voxpupuli/puppet-nginx/issues/393)
- Run as different user [\#392](https://github.com/voxpupuli/puppet-nginx/issues/392)
- Typo in init.pp, global/sites params it refers to are not prefixed with nx\_ [\#375](https://github.com/voxpupuli/puppet-nginx/issues/375)
- Could not find class concat [\#374](https://github.com/voxpupuli/puppet-nginx/issues/374)
- Arbitrary directives for global and http contexts [\#361](https://github.com/voxpupuli/puppet-nginx/issues/361)
- \#331 fundamentally doesn't work [\#335](https://github.com/voxpupuli/puppet-nginx/issues/335)
- proxy\_connect\_timeout [\#324](https://github.com/voxpupuli/puppet-nginx/issues/324)
- What do you mean ruby 1.8.7 is not working? [\#309](https://github.com/voxpupuli/puppet-nginx/issues/309)
- autoindex in location.pp does not work [\#304](https://github.com/voxpupuli/puppet-nginx/issues/304)
- Module fails on ubuntu trusty [\#303](https://github.com/voxpupuli/puppet-nginx/issues/303)
- Unable to create long temp concat files for long locations [\#297](https://github.com/voxpupuli/puppet-nginx/issues/297)
- Extra coma on init.pp [\#291](https://github.com/voxpupuli/puppet-nginx/issues/291)
- conf.d/default.conf is being created [\#263](https://github.com/voxpupuli/puppet-nginx/issues/263)
- Support map blocks [\#258](https://github.com/voxpupuli/puppet-nginx/issues/258)
- gzip is not enabled [\#256](https://github.com/voxpupuli/puppet-nginx/issues/256)
- Service\[nginx\] seems to have an exec that fails due to being an empty string [\#242](https://github.com/voxpupuli/puppet-nginx/issues/242)
- Change $service\_restart custom command to use "nginx -t" by default [\#182](https://github.com/voxpupuli/puppet-nginx/issues/182)
- Can I change nx\_events\_use parameter? [\#76](https://github.com/voxpupuli/puppet-nginx/issues/76)

**Merged pull requests:**

- Add FreeBSD Support [\#376](https://github.com/voxpupuli/puppet-nginx/pull/376) ([xaque208](https://github.com/xaque208))
- Added owner group and mode parameter. For all users, per sites-available... [\#373](https://github.com/voxpupuli/puppet-nginx/pull/373) ([alkivi-sas](https://github.com/alkivi-sas))
- Changed testing variables in init.pp [\#371](https://github.com/voxpupuli/puppet-nginx/pull/371) ([mr-tron](https://github.com/mr-tron))
- Allow using $http\_cfg\_append with list of lists [\#369](https://github.com/voxpupuli/puppet-nginx/pull/369) ([motiejus](https://github.com/motiejus))
- Change travis to exclude unwanted branches [\#368](https://github.com/voxpupuli/puppet-nginx/pull/368) ([janorn](https://github.com/janorn))
- new raw\_prepend / raw\_append feature for vhosts & locations [\#365](https://github.com/voxpupuli/puppet-nginx/pull/365) ([rabbitt](https://github.com/rabbitt))
- allows setting client\_body/header\_timeout and gzip\_types on vhosts [\#362](https://github.com/voxpupuli/puppet-nginx/pull/362) ([eholzbach](https://github.com/eholzbach))
- $ssl implied by $ssl\_only [\#357](https://github.com/voxpupuli/puppet-nginx/pull/357) ([nalbion](https://github.com/nalbion))
- Add more spec tests [\#355](https://github.com/voxpupuli/puppet-nginx/pull/355) ([janorn](https://github.com/janorn))
- Add client\_body\_temp\_path and proxy\_temp\_path to proxy.conf. [\#354](https://github.com/voxpupuli/puppet-nginx/pull/354) ([janorn](https://github.com/janorn))
- Puppet-lint fix. Enclosing variable [\#353](https://github.com/voxpupuli/puppet-nginx/pull/353) ([hundredacres](https://github.com/hundredacres))
- refactor locations to remove a bit of redundancy [\#352](https://github.com/voxpupuli/puppet-nginx/pull/352) ([rabbitt](https://github.com/rabbitt))
- add ability to designate location as internal [\#351](https://github.com/voxpupuli/puppet-nginx/pull/351) ([rabbitt](https://github.com/rabbitt))
- allow override of proxy\_redirect = off [\#350](https://github.com/voxpupuli/puppet-nginx/pull/350) ([eholzbach](https://github.com/eholzbach))
- use 'return' over 'rewrite' [\#349](https://github.com/voxpupuli/puppet-nginx/pull/349) ([rabbitt](https://github.com/rabbitt))
- Reintegrate jfryman/puppet-nginx\#331 \(upstream exports/collections\) [\#347](https://github.com/voxpupuli/puppet-nginx/pull/347) ([rabbitt](https://github.com/rabbitt))
- Ability to turn off sendfile [\#343](https://github.com/voxpupuli/puppet-nginx/pull/343) ([globin](https://github.com/globin))
- Suse packages [\#342](https://github.com/voxpupuli/puppet-nginx/pull/342) ([globin](https://github.com/globin))
- Change nx\_conf\_dir to config::conf\_dir [\#339](https://github.com/voxpupuli/puppet-nginx/pull/339) ([janorn](https://github.com/janorn))
- Add nginx config dir as a parameter [\#338](https://github.com/voxpupuli/puppet-nginx/pull/338) ([janorn](https://github.com/janorn))
- add ability to define geo and map mappings [\#337](https://github.com/voxpupuli/puppet-nginx/pull/337) ([rabbitt](https://github.com/rabbitt))
- Revert "Added ngnix::resources::upstream::member" [\#336](https://github.com/voxpupuli/puppet-nginx/pull/336) ([leepa](https://github.com/leepa))
- Fix all rspec tests so they run [\#334](https://github.com/voxpupuli/puppet-nginx/pull/334) ([leepa](https://github.com/leepa))
- Allow format\_log in ssl vhosts as well [\#332](https://github.com/voxpupuli/puppet-nginx/pull/332) ([kimor79](https://github.com/kimor79))
- Upstream members can be exported and collected [\#331](https://github.com/voxpupuli/puppet-nginx/pull/331) ([rainopik](https://github.com/rainopik))
- make ssl listen option configurable [\#330](https://github.com/voxpupuli/puppet-nginx/pull/330) ([saz](https://github.com/saz))
- Fix validation of events\_use parameter [\#329](https://github.com/voxpupuli/puppet-nginx/pull/329) ([saz](https://github.com/saz))
- Run as unprivileged user [\#328](https://github.com/voxpupuli/puppet-nginx/pull/328) ([janorn](https://github.com/janorn))
- Puppet-lint fixes [\#327](https://github.com/voxpupuli/puppet-nginx/pull/327) ([hundredacres](https://github.com/hundredacres))
- Make proxy variables configurable via hiera [\#326](https://github.com/voxpupuli/puppet-nginx/pull/326) ([janorn](https://github.com/janorn))
- Sorted all parameters alphabetically in the main nginx class [\#325](https://github.com/voxpupuli/puppet-nginx/pull/325) ([janorn](https://github.com/janorn))
- add option for multi\_accept and events\_use [\#323](https://github.com/voxpupuli/puppet-nginx/pull/323) ([saz](https://github.com/saz))
- Fix error message if ssl\_cert/ssl\_key is not set. [\#321](https://github.com/voxpupuli/puppet-nginx/pull/321) ([saz](https://github.com/saz))
- Add client\_max\_body\_size to ssl vhost [\#320](https://github.com/voxpupuli/puppet-nginx/pull/320) ([timmow](https://github.com/timmow))
- Enabled undef for service where we dont want puppet control service [\#319](https://github.com/voxpupuli/puppet-nginx/pull/319) ([zdenekjanda](https://github.com/zdenekjanda))
- Add Archlinux support [\#316](https://github.com/voxpupuli/puppet-nginx/pull/316) ([ghost](https://github.com/ghost))
- Allow basic\_auth for proxy locations and ... [\#315](https://github.com/voxpupuli/puppet-nginx/pull/315) ([dkerwin](https://github.com/dkerwin))
- Pull request 269 revisited [\#314](https://github.com/voxpupuli/puppet-nginx/pull/314) ([janorn](https://github.com/janorn))
- add location\_allow/deny directives for alias and stub\_status templates [\#311](https://github.com/voxpupuli/puppet-nginx/pull/311) ([alexskr](https://github.com/alexskr))
- Use first server name for non-www redirects to prevent issues with naming of vhosts within defined types. [\#310](https://github.com/voxpupuli/puppet-nginx/pull/310) ([kalmanolah](https://github.com/kalmanolah))
- allow resolvers in non-ssl vhosts [\#307](https://github.com/voxpupuli/puppet-nginx/pull/307) ([mike-lerch](https://github.com/mike-lerch))
- Added support for fastcgi parameters. [\#306](https://github.com/voxpupuli/puppet-nginx/pull/306) ([mtomic](https://github.com/mtomic))
- Adding autoindex to location alias [\#305](https://github.com/voxpupuli/puppet-nginx/pull/305) ([andschwa](https://github.com/andschwa))
- nginx::package::debian: only include ::apt when needed [\#302](https://github.com/voxpupuli/puppet-nginx/pull/302) ([yath](https://github.com/yath))
- fix location sanitizing with parser 'future' [\#301](https://github.com/voxpupuli/puppet-nginx/pull/301) ([yath](https://github.com/yath))
- Introduced log\_by\_lua and log\_by\_lua\_file params. [\#300](https://github.com/voxpupuli/puppet-nginx/pull/300) ([hdanes](https://github.com/hdanes))
- Fix cannot generate tempfile error [\#298](https://github.com/voxpupuli/puppet-nginx/pull/298) ([pennycoders](https://github.com/pennycoders))
- Stop using $root from upper scopes [\#296](https://github.com/voxpupuli/puppet-nginx/pull/296) ([radford](https://github.com/radford))
- Fix cert sanitized and add some options [\#295](https://github.com/voxpupuli/puppet-nginx/pull/295) ([abraham1901](https://github.com/abraham1901))
- Added nginx::resource::mailhost to be configured via hiera [\#293](https://github.com/voxpupuli/puppet-nginx/pull/293) ([dol](https://github.com/dol))
- Add configuring multiple resolvers via an array instead of a string [\#290](https://github.com/voxpupuli/puppet-nginx/pull/290) ([pderaaij](https://github.com/pderaaij))
- Add additional config to the locations resource and fix set\_header in vhost resource [\#289](https://github.com/voxpupuli/puppet-nginx/pull/289) ([b4ldr](https://github.com/b4ldr))
- Fixed lint errors [\#287](https://github.com/voxpupuli/puppet-nginx/pull/287) ([justinhennessy](https://github.com/justinhennessy))
- Removing default.conf and example\_ssl.conf [\#285](https://github.com/voxpupuli/puppet-nginx/pull/285) ([seocam](https://github.com/seocam))
- allow setting custom priority before and after default SSL priority [\#284](https://github.com/voxpupuli/puppet-nginx/pull/284) ([CpuID](https://github.com/CpuID))
- Make proxy\_redirect configurable [\#282](https://github.com/voxpupuli/puppet-nginx/pull/282) ([genehand](https://github.com/genehand))

## [v0.0.9](https://github.com/voxpupuli/puppet-nginx/tree/v0.0.9) (2014-03-27)

[Full Changelog](https://github.com/voxpupuli/puppet-nginx/compare/v0.0.8...v0.0.9)

**Closed issues:**

- Version bump [\#268](https://github.com/voxpupuli/puppet-nginx/issues/268)
- nginx::params is deprecated as a public API [\#240](https://github.com/voxpupuli/puppet-nginx/issues/240)

**Merged pull requests:**

- Remove Deprecation Warnings [\#283](https://github.com/voxpupuli/puppet-nginx/pull/283) ([jfryman](https://github.com/jfryman))
- Add allow/deny rules to fastcgi template [\#281](https://github.com/voxpupuli/puppet-nginx/pull/281) ([globin](https://github.com/globin))
- SmartOS support [\#280](https://github.com/voxpupuli/puppet-nginx/pull/280) ([ok-devalias](https://github.com/ok-devalias))

## [v0.0.8](https://github.com/voxpupuli/puppet-nginx/tree/v0.0.8) (2014-03-20)

[Full Changelog](https://github.com/voxpupuli/puppet-nginx/compare/v0.0.7...v0.0.8)

**Closed issues:**

- Bypass proxy for static files [\#251](https://github.com/voxpupuli/puppet-nginx/issues/251)
- PR \#227 breaks setting multiple options of same type with location\_cfg\_append/location\_cfg\_prepend [\#234](https://github.com/voxpupuli/puppet-nginx/issues/234)
- location in vhost generated in wrong place, nginx syntax error [\#224](https://github.com/voxpupuli/puppet-nginx/issues/224)
- error\_page configuration [\#40](https://github.com/voxpupuli/puppet-nginx/issues/40)

**Merged pull requests:**

- fix missing ensure on concat::fragment resources [\#278](https://github.com/voxpupuli/puppet-nginx/pull/278) ([jfroche](https://github.com/jfroche))
- remove unknown parameter [\#277](https://github.com/voxpupuli/puppet-nginx/pull/277) ([jfroche](https://github.com/jfroche))
- Update README.markdown - set minimium ruby version [\#276](https://github.com/voxpupuli/puppet-nginx/pull/276) ([grooverdan](https://github.com/grooverdan))
- New parameter worker\_rlimit\_nofile [\#275](https://github.com/voxpupuli/puppet-nginx/pull/275) ([dkerwin](https://github.com/dkerwin))
- Make template for nginx.conf.erb configurable [\#272](https://github.com/voxpupuli/puppet-nginx/pull/272) ([DracoBlue](https://github.com/DracoBlue))
- Ensure that vhosts are purged with new parameter purge\_vhost [\#271](https://github.com/voxpupuli/puppet-nginx/pull/271) ([zdenekjanda](https://github.com/zdenekjanda))
- Allow values to be hashes at prepend,append,custom cfg for locations [\#266](https://github.com/voxpupuli/puppet-nginx/pull/266) ([ese](https://github.com/ese))
- Puppet removes dir only if "force =\> true" [\#265](https://github.com/voxpupuli/puppet-nginx/pull/265) ([huandu](https://github.com/huandu))
- add service\_ensure support [\#264](https://github.com/voxpupuli/puppet-nginx/pull/264) ([welterde](https://github.com/welterde))
- add location\_custom\_cfg\_prepend support [\#259](https://github.com/voxpupuli/puppet-nginx/pull/259) ([pessoa](https://github.com/pessoa))
- Bugfix: Add missing gzip parameter [\#257](https://github.com/voxpupuli/puppet-nginx/pull/257) ([swanke](https://github.com/swanke))
- Bugfix autoindex in nginx::resource::vhost [\#255](https://github.com/voxpupuli/puppet-nginx/pull/255) ([bionix](https://github.com/bionix))
- Added vhost ssl prepend and append [\#254](https://github.com/voxpupuli/puppet-nginx/pull/254) ([cdenneen](https://github.com/cdenneen))
- Allow location\_{allow,deny} parameter to be used for proxy locations [\#253](https://github.com/voxpupuli/puppet-nginx/pull/253) ([fadenb](https://github.com/fadenb))
- Fix nginx::params deprecation notice [\#252](https://github.com/voxpupuli/puppet-nginx/pull/252) ([createdbypete](https://github.com/createdbypete))
- Update test to reflect modified template from \#171 [\#250](https://github.com/voxpupuli/puppet-nginx/pull/250) ([fadenb](https://github.com/fadenb))
- Bugfix for duplicate listen option caused by hardcoded `ipv6only=on` in template [\#249](https://github.com/voxpupuli/puppet-nginx/pull/249) ([fadenb](https://github.com/fadenb))
- Avoid creating undef variable [\#248](https://github.com/voxpupuli/puppet-nginx/pull/248) ([PierreR](https://github.com/PierreR))
- Added basic support for nginx on Solaris. [\#247](https://github.com/voxpupuli/puppet-nginx/pull/247) ([janorn](https://github.com/janorn))
- Adding client\_max\_body\_size. [\#246](https://github.com/voxpupuli/puppet-nginx/pull/246) ([thomasbiddle](https://github.com/thomasbiddle))
- Sort @passenger\_cgi\_param to make sure generated config file content is stable. [\#243](https://github.com/voxpupuli/puppet-nginx/pull/243) ([huandu](https://github.com/huandu))
- Make gzip configurable [\#239](https://github.com/voxpupuli/puppet-nginx/pull/239) ([mlandewers](https://github.com/mlandewers))
- remove changelog [\#238](https://github.com/voxpupuli/puppet-nginx/pull/238) ([3flex](https://github.com/3flex))
- workaround missing librarian-puppet-maestrodev dependencies [\#237](https://github.com/voxpupuli/puppet-nginx/pull/237) ([3flex](https://github.com/3flex))
- manifests/conf.pp: fixed a typo in error message. [\#236](https://github.com/voxpupuli/puppet-nginx/pull/236) ([php-coder](https://github.com/php-coder))
- added rewrite to location/proxy & vhost [\#235](https://github.com/voxpupuli/puppet-nginx/pull/235) ([3flex](https://github.com/3flex))
- Fixed long names virtual hosts... [\#233](https://github.com/voxpupuli/puppet-nginx/pull/233) ([abraham1901](https://github.com/abraham1901))
- \(Revised Commit\) Support for server\_names\_hash\_bucket\_size and server\_names\_hash\_max\_size [\#231](https://github.com/voxpupuli/puppet-nginx/pull/231) ([CpuID](https://github.com/CpuID))
- README updates [\#230](https://github.com/voxpupuli/puppet-nginx/pull/230) ([3flex](https://github.com/3flex))
- Fix multi-line comment indentation [\#228](https://github.com/voxpupuli/puppet-nginx/pull/228) ([PierreR](https://github.com/PierreR))
- Validations for all parameters in the public classes [\#227](https://github.com/voxpupuli/puppet-nginx/pull/227) ([3flex](https://github.com/3flex))
- Fix a config error in the last sample in README [\#226](https://github.com/voxpupuli/puppet-nginx/pull/226) ([huandu](https://github.com/huandu))
- Fix index\_files ivar warning [\#225](https://github.com/voxpupuli/puppet-nginx/pull/225) ([chrisdambrosio](https://github.com/chrisdambrosio))
- Add validation for location $priority [\#223](https://github.com/voxpupuli/puppet-nginx/pull/223) ([3flex](https://github.com/3flex))
- Adding upstream fail\_timeout. [\#171](https://github.com/voxpupuli/puppet-nginx/pull/171) ([thomasbiddle](https://github.com/thomasbiddle))

## [v0.0.7](https://github.com/voxpupuli/puppet-nginx/tree/v0.0.7) (2014-01-02)

[Full Changelog](https://github.com/voxpupuli/puppet-nginx/compare/v0.0.6...v0.0.7)

**Closed issues:**

- travis enable [\#205](https://github.com/voxpupuli/puppet-nginx/issues/205)
- IPv6 SSL Port [\#198](https://github.com/voxpupuli/puppet-nginx/issues/198)
- \(regression\) nested server directives when using SSL vhost [\#186](https://github.com/voxpupuli/puppet-nginx/issues/186)
- new release [\#180](https://github.com/voxpupuli/puppet-nginx/issues/180)
- Add OracleLinux value to operating system matching in params [\#176](https://github.com/voxpupuli/puppet-nginx/issues/176)
- Always create new changes after restart [\#159](https://github.com/voxpupuli/puppet-nginx/issues/159)
- Switch to puppetlabs-concat? [\#135](https://github.com/voxpupuli/puppet-nginx/issues/135)
- Make SPDY a toggle parameter at declaration [\#73](https://github.com/voxpupuli/puppet-nginx/issues/73)
- Package conflict on Debian [\#71](https://github.com/voxpupuli/puppet-nginx/issues/71)
- Add rspec-puppet test coverage to this module [\#65](https://github.com/voxpupuli/puppet-nginx/issues/65)
- Bug in ipv6 template [\#30](https://github.com/voxpupuli/puppet-nginx/issues/30)

**Merged pull requests:**

- Separating the options with a space to avoid invalid one like "ssldefault" [\#218](https://github.com/voxpupuli/puppet-nginx/pull/218) ([andreyev](https://github.com/andreyev))
- Fix "invalid byte sequence in UTF-8" errors introduced in \#213 [\#216](https://github.com/voxpupuli/puppet-nginx/pull/216) ([3flex](https://github.com/3flex))
- Update tests broken by merging \#203 [\#215](https://github.com/voxpupuli/puppet-nginx/pull/215) ([3flex](https://github.com/3flex))
- Fix warning: Variable access via 'index\_files' is deprecated. [\#214](https://github.com/voxpupuli/puppet-nginx/pull/214) ([hdanes](https://github.com/hdanes))
- Added support for SSL stapling of OCSP responses. [\#213](https://github.com/voxpupuli/puppet-nginx/pull/213) ([hdanes](https://github.com/hdanes))
- Add support for Diffie-Hellman \(SSL\) parameters in VHOST resource. [\#212](https://github.com/voxpupuli/puppet-nginx/pull/212) ([hdanes](https://github.com/hdanes))
- Fixed the ability to disable the index\_files [\#211](https://github.com/voxpupuli/puppet-nginx/pull/211) ([abraham1901](https://github.com/abraham1901))
- Bugfix: Fixed location containing '\', such as '~ \.php$' [\#210](https://github.com/voxpupuli/puppet-nginx/pull/210) ([abraham1901](https://github.com/abraham1901))
- Bugfix: Fixed long names virtual hosts [\#209](https://github.com/voxpupuli/puppet-nginx/pull/209) ([abraham1901](https://github.com/abraham1901))
- Add the possibility to add a header to the HTTP response [\#208](https://github.com/voxpupuli/puppet-nginx/pull/208) ([hdanes](https://github.com/hdanes))
- provide visibility of Travis status [\#206](https://github.com/voxpupuli/puppet-nginx/pull/206) ([3flex](https://github.com/3flex))
- index\_files to be defined at server level if specified in resource::vhost [\#204](https://github.com/voxpupuli/puppet-nginx/pull/204) ([grooverdan](https://github.com/grooverdan))
- ipv6 port to ssl\_port with ssl and spdy \(if enabled\) options [\#203](https://github.com/voxpupuli/puppet-nginx/pull/203) ([grooverdan](https://github.com/grooverdan))
- Add proxy\_set\_header to vhost\_ssl\_header to be the same as vhost\_header [\#202](https://github.com/voxpupuli/puppet-nginx/pull/202) ([grooverdan](https://github.com/grooverdan))
- Fix for order statements. Concat requires strings [\#197](https://github.com/voxpupuli/puppet-nginx/pull/197) ([elmerfud](https://github.com/elmerfud))
- Add nginx autoindex to resource nginx::location and style up the nginx::vhost directory template [\#195](https://github.com/voxpupuli/puppet-nginx/pull/195) ([bionix](https://github.com/bionix))
- Add nginx::vhost option 'autoindex' [\#194](https://github.com/voxpupuli/puppet-nginx/pull/194) ([bionix](https://github.com/bionix))
- rspec-puppet 1.0.0 [\#192](https://github.com/voxpupuli/puppet-nginx/pull/192) ([3flex](https://github.com/3flex))
- Rspec tests \(and fixes\) [\#188](https://github.com/voxpupuli/puppet-nginx/pull/188) ([3flex](https://github.com/3flex))
- Update vhost.pp [\#184](https://github.com/voxpupuli/puppet-nginx/pull/184) ([abraham1901](https://github.com/abraham1901))
- Update params to account for oracle linux. [\#183](https://github.com/voxpupuli/puppet-nginx/pull/183) ([drfeelngood](https://github.com/drfeelngood))
- \(maint\) Fix Puppet 3.2.x deprecation warnings [\#175](https://github.com/voxpupuli/puppet-nginx/pull/175) ([3flex](https://github.com/3flex))
- Add support for proxy method and body [\#170](https://github.com/voxpupuli/puppet-nginx/pull/170) ([arlimus](https://github.com/arlimus))
- Switch to using concat{} instead of lots of file{} magic. [\#167](https://github.com/voxpupuli/puppet-nginx/pull/167) ([3flex](https://github.com/3flex))

## [v0.0.6](https://github.com/voxpupuli/puppet-nginx/tree/v0.0.6) (2013-10-25)

[Full Changelog](https://github.com/voxpupuli/puppet-nginx/compare/v0.0.5...v0.0.6)

**Closed issues:**

- Git merge artifacts left in init.pp [\#153](https://github.com/voxpupuli/puppet-nginx/issues/153)
- Errors & Fails to set file if location name includes a slash [\#102](https://github.com/voxpupuli/puppet-nginx/issues/102)
- what's the best way to ensure a certain version of nginx package gets installed [\#66](https://github.com/voxpupuli/puppet-nginx/issues/66)
- location\_cfg\_prepend hash keys ignored [\#49](https://github.com/voxpupuli/puppet-nginx/issues/49)

**Merged pull requests:**

- Fix upstream\_cfg\_prepend loop to put every element on a dedicated line [\#166](https://github.com/voxpupuli/puppet-nginx/pull/166) ([dkerwin](https://github.com/dkerwin))
- Rspec fixes [\#165](https://github.com/voxpupuli/puppet-nginx/pull/165) ([3flex](https://github.com/3flex))
- Validate all arrays [\#164](https://github.com/voxpupuli/puppet-nginx/pull/164) ([3flex](https://github.com/3flex))
- Add Travis config [\#163](https://github.com/voxpupuli/puppet-nginx/pull/163) ([3flex](https://github.com/3flex))
- Regex replace / in resource::vhost [\#162](https://github.com/voxpupuli/puppet-nginx/pull/162) ([jfryman](https://github.com/jfryman))
- Fix RHEL installation support [\#158](https://github.com/voxpupuli/puppet-nginx/pull/158) ([miguno](https://github.com/miguno))
- Fix dependency problems with APT repo handling [\#155](https://github.com/voxpupuli/puppet-nginx/pull/155) ([fpletz](https://github.com/fpletz))
- Fixing broken merge [\#154](https://github.com/voxpupuli/puppet-nginx/pull/154) ([narkisr](https://github.com/narkisr))
- Added example of passenger usage [\#151](https://github.com/voxpupuli/puppet-nginx/pull/151) ([deric](https://github.com/deric))
- support for nginx passenger debian repositories [\#145](https://github.com/voxpupuli/puppet-nginx/pull/145) ([deric](https://github.com/deric))
- Added class param to disable YUM repo management on RedHat platforms [\#144](https://github.com/voxpupuli/puppet-nginx/pull/144) ([rytis](https://github.com/rytis))
- Fix stub\_status location so it has line breaks. [\#141](https://github.com/voxpupuli/puppet-nginx/pull/141) ([vrillusions](https://github.com/vrillusions))
- Fix deprecated variable access warning in vhost footer template [\#140](https://github.com/voxpupuli/puppet-nginx/pull/140) ([alanpearce](https://github.com/alanpearce))
- make proxy\_buffers, proxy\_buffer\_size, client\_max\_body\_size configurable [\#139](https://github.com/voxpupuli/puppet-nginx/pull/139) ([OmarzT](https://github.com/OmarzT))
- Switch to using puppetlabs-apt [\#134](https://github.com/voxpupuli/puppet-nginx/pull/134) ([apenney](https://github.com/apenney))
- Add basic rspec-system tests. [\#133](https://github.com/voxpupuli/puppet-nginx/pull/133) ([apenney](https://github.com/apenney))
- \#66: This commit allows you to set package\_ensure in nginx and have that [\#132](https://github.com/voxpupuli/puppet-nginx/pull/132) ([apenney](https://github.com/apenney))
- location\_allow and location\_deny support. [\#131](https://github.com/voxpupuli/puppet-nginx/pull/131) ([apenney](https://github.com/apenney))
- Use correct port for www rewrite [\#128](https://github.com/voxpupuli/puppet-nginx/pull/128) ([leoc](https://github.com/leoc))
- Fix typo in vhost\_header [\#125](https://github.com/voxpupuli/puppet-nginx/pull/125) ([theospears](https://github.com/theospears))
- sort $vhost\_cfg\_append hash in vhost\_footer.erb template [\#123](https://github.com/voxpupuli/puppet-nginx/pull/123) ([jhoblitt](https://github.com/jhoblitt))
- Update README to use syntax highlighting [\#122](https://github.com/voxpupuli/puppet-nginx/pull/122) ([blkperl](https://github.com/blkperl))
- Aggregated some PR & tested & simple bug fix & add new option [\#120](https://github.com/voxpupuli/puppet-nginx/pull/120) ([abraham1901](https://github.com/abraham1901))
- Fix SSL cert and key permissions [\#119](https://github.com/voxpupuli/puppet-nginx/pull/119) ([tombooth](https://github.com/tombooth))

## [v0.0.5](https://github.com/voxpupuli/puppet-nginx/tree/v0.0.5) (2013-08-25)

[Full Changelog](https://github.com/voxpupuli/puppet-nginx/compare/v0.0.4...v0.0.5)

**Merged pull requests:**

- \* Bug fix, remove each\_line method [\#121](https://github.com/voxpupuli/puppet-nginx/pull/121) ([abraham1901](https://github.com/abraham1901))

## [v0.0.4](https://github.com/voxpupuli/puppet-nginx/tree/v0.0.4) (2013-08-22)

[Full Changelog](https://github.com/voxpupuli/puppet-nginx/compare/v0.0.3...v0.0.4)

**Closed issues:**

- Final Test [\#118](https://github.com/voxpupuli/puppet-nginx/issues/118)
- another webhook test. [\#117](https://github.com/voxpupuli/puppet-nginx/issues/117)
- Testing webhook [\#116](https://github.com/voxpupuli/puppet-nginx/issues/116)

**Merged pull requests:**

- sort $vhost\_cfg\_append hash in vhost\_footer.erb template [\#115](https://github.com/voxpupuli/puppet-nginx/pull/115) ([jhoblitt](https://github.com/jhoblitt))
- Please reconsidere my pull request: Fix syntax "each" for ruby1.9 =\> each\_line and add listen\_port on rewrite\_www\_to\_non\_www [\#114](https://github.com/voxpupuli/puppet-nginx/pull/114) ([helldorado](https://github.com/helldorado))
- Fix the error 'You cannot specify more than one of content, source, target' [\#109](https://github.com/voxpupuli/puppet-nginx/pull/109) ([vikraman](https://github.com/vikraman))
- fix template, should use @ [\#104](https://github.com/voxpupuli/puppet-nginx/pull/104) ([stephenrjohnson](https://github.com/stephenrjohnson))
- update nginx::package to select the package class by $::osfamily [\#99](https://github.com/voxpupuli/puppet-nginx/pull/99) ([jhoblitt](https://github.com/jhoblitt))

## [v0.0.3](https://github.com/voxpupuli/puppet-nginx/tree/v0.0.3) (2013-08-04)

[Full Changelog](https://github.com/voxpupuli/puppet-nginx/compare/v0.0.2...v0.0.3)

**Closed issues:**

- hiera resources don't process ssl locations properly [\#106](https://github.com/voxpupuli/puppet-nginx/issues/106)

**Merged pull requests:**

- Fix \#106 when using wildcard certificate on multiple vhosts [\#107](https://github.com/voxpupuli/puppet-nginx/pull/107) ([xcompass](https://github.com/xcompass))
- Some changes have been made [\#103](https://github.com/voxpupuli/puppet-nginx/pull/103) ([abraham1901](https://github.com/abraham1901))
- auth\_basic lines appearing in SSL vhost header when they shouldn't [\#101](https://github.com/voxpupuli/puppet-nginx/pull/101) ([adambrenecki](https://github.com/adambrenecki))
- Fixed RHEL package install and added some fastcgi options [\#97](https://github.com/voxpupuli/puppet-nginx/pull/97) ([justicel](https://github.com/justicel))

## [v0.0.2](https://github.com/voxpupuli/puppet-nginx/tree/v0.0.2) (2013-08-01)

[Full Changelog](https://github.com/voxpupuli/puppet-nginx/compare/show...v0.0.2)

**Closed issues:**

- UWSGI Proxying [\#82](https://github.com/voxpupuli/puppet-nginx/issues/82)
- GeoIP package missing in Centos [\#74](https://github.com/voxpupuli/puppet-nginx/issues/74)
- Convert all true/false to booleans [\#61](https://github.com/voxpupuli/puppet-nginx/issues/61)
- Need help using the vhost resource [\#60](https://github.com/voxpupuli/puppet-nginx/issues/60)
- Pull request \#53 contains broken vhost.pp [\#55](https://github.com/voxpupuli/puppet-nginx/issues/55)
- Build a new house [\#46](https://github.com/voxpupuli/puppet-nginx/issues/46)
- Fix List [\#45](https://github.com/voxpupuli/puppet-nginx/issues/45)
- Having a issue with hiera [\#22](https://github.com/voxpupuli/puppet-nginx/issues/22)
- Running from scratch gives error on cat nginx.d/\* [\#20](https://github.com/voxpupuli/puppet-nginx/issues/20)
- Make sure latest stable release of nginx is installed [\#7](https://github.com/voxpupuli/puppet-nginx/issues/7)
- Ubuntu 10.04 failed to fetch repository bug [\#3](https://github.com/voxpupuli/puppet-nginx/issues/3)

**Merged pull requests:**

- Inverted condition for IPv6 warning   [\#98](https://github.com/voxpupuli/puppet-nginx/pull/98) ([mnencia](https://github.com/mnencia))
- Adding option http\_cfg\_append to class nginx [\#96](https://github.com/voxpupuli/puppet-nginx/pull/96) ([abraham1901](https://github.com/abraham1901))
- Add Hiera support [\#95](https://github.com/voxpupuli/puppet-nginx/pull/95) ([xcompass](https://github.com/xcompass))
- Remove GeoIP in spec to fix the tests [\#94](https://github.com/voxpupuli/puppet-nginx/pull/94) ([xcompass](https://github.com/xcompass))
- Fix undefined method `sort\_by' error from vhost\_location\_empty.erb [\#93](https://github.com/voxpupuli/puppet-nginx/pull/93) ([xcompass](https://github.com/xcompass))
- Fix deprecated variable names [\#92](https://github.com/voxpupuli/puppet-nginx/pull/92) ([leoc](https://github.com/leoc))
- Add index\_files to location for vhost [\#90](https://github.com/voxpupuli/puppet-nginx/pull/90) ([michaeltchapman](https://github.com/michaeltchapman))
- Sort location\_custom\_cfg hash to prevent random ordering [\#87](https://github.com/voxpupuli/puppet-nginx/pull/87) ([jamorton](https://github.com/jamorton))
- Add location priority option [\#86](https://github.com/voxpupuli/puppet-nginx/pull/86) ([abraham1901](https://github.com/abraham1901))
- Fixed log name  and better formatting [\#85](https://github.com/voxpupuli/puppet-nginx/pull/85) ([abraham1901](https://github.com/abraham1901))
- Added gpgcheck to redhat yum repo configuration. [\#84](https://github.com/voxpupuli/puppet-nginx/pull/84) ([salekseev](https://github.com/salekseev))
- Add support for fully custom location configurations. [\#83](https://github.com/voxpupuli/puppet-nginx/pull/83) ([jamorton](https://github.com/jamorton))
- Parameter server\_tokens of nginx class is actually never used [\#81](https://github.com/voxpupuli/puppet-nginx/pull/81) ([msiedlarek](https://github.com/msiedlarek))
- Changes to SSL and SPDY [\#77](https://github.com/voxpupuli/puppet-nginx/pull/77) ([igoraj](https://github.com/igoraj))
- Add server\_names\_hash\_bucket\_size param [\#75](https://github.com/voxpupuli/puppet-nginx/pull/75) ([thaumazein](https://github.com/thaumazein))
- Gentoo support [\#72](https://github.com/voxpupuli/puppet-nginx/pull/72) ([castiel](https://github.com/castiel))
- Removed various puppet-lint warnings and fixed a typo [\#69](https://github.com/voxpupuli/puppet-nginx/pull/69) ([ghost](https://github.com/ghost))
- Push to forge [\#68](https://github.com/voxpupuli/puppet-nginx/pull/68) ([carlossg](https://github.com/carlossg))
- Add specs using puppetlabs\_spec\_helper and librarian-puppet [\#67](https://github.com/voxpupuli/puppet-nginx/pull/67) ([carlossg](https://github.com/carlossg))
- Fixing boolean comparisons [\#63](https://github.com/voxpupuli/puppet-nginx/pull/63) ([zoide](https://github.com/zoide))
- Fixed errors and implemented new functions [\#59](https://github.com/voxpupuli/puppet-nginx/pull/59) ([abraham1901](https://github.com/abraham1901))
- Added composer support [\#58](https://github.com/voxpupuli/puppet-nginx/pull/58) ([frastel](https://github.com/frastel))
- Use official nginx apt repo of stable releases for debian/ubuntu [\#57](https://github.com/voxpupuli/puppet-nginx/pull/57) ([ktham](https://github.com/ktham))
- Pull request \#53 contains broken vhost.pp [\#56](https://github.com/voxpupuli/puppet-nginx/pull/56) ([LeeXGreen](https://github.com/LeeXGreen))
- Added params for types\_hash\_max\_size and types\_hash\_bucket\_size expected... [\#54](https://github.com/voxpupuli/puppet-nginx/pull/54) ([squidsoup](https://github.com/squidsoup))
- Added some minor enhancements [\#53](https://github.com/voxpupuli/puppet-nginx/pull/53) ([hingstarne](https://github.com/hingstarne))
- Stabilize key/value output by sorting hashes on key. [\#52](https://github.com/voxpupuli/puppet-nginx/pull/52) ([iksteen](https://github.com/iksteen))
- linting [\#51](https://github.com/voxpupuli/puppet-nginx/pull/51) ([tjikkun](https://github.com/tjikkun))
- Proxy http version [\#50](https://github.com/voxpupuli/puppet-nginx/pull/50) ([tjikkun](https://github.com/tjikkun))
- SSL improvements \(default ciphers & caching\), server\_tokens option, and proxy\_set\_headers for vhosts [\#48](https://github.com/voxpupuli/puppet-nginx/pull/48) ([buro9](https://github.com/buro9))
- Add support for upstream\_cfg\_prepend [\#47](https://github.com/voxpupuli/puppet-nginx/pull/47) ([tjikkun](https://github.com/tjikkun))
- more boolean comparison fixes [\#44](https://github.com/voxpupuli/puppet-nginx/pull/44) ([zoide](https://github.com/zoide))
- Ssl fixes [\#43](https://github.com/voxpupuli/puppet-nginx/pull/43) ([zoide](https://github.com/zoide))
- Fixed typo in init.pp [\#42](https://github.com/voxpupuli/puppet-nginx/pull/42) ([igoraj](https://github.com/igoraj))
- add support for mail module [\#41](https://github.com/voxpupuli/puppet-nginx/pull/41) ([tjikkun](https://github.com/tjikkun))
- Amazon Linux support [\#39](https://github.com/voxpupuli/puppet-nginx/pull/39) ([ryanfitz](https://github.com/ryanfitz))
- Add scientific linux support [\#37](https://github.com/voxpupuli/puppet-nginx/pull/37) ([hunner](https://github.com/hunner))
- Add scientific linux support [\#36](https://github.com/voxpupuli/puppet-nginx/pull/36) ([hunner](https://github.com/hunner))
- Add try\_files option [\#35](https://github.com/voxpupuli/puppet-nginx/pull/35) ([hunner](https://github.com/hunner))
- Support for SSL only server and SSL defined port [\#33](https://github.com/voxpupuli/puppet-nginx/pull/33) ([juaningan](https://github.com/juaningan))
- Fix syntax error in ERB template [\#32](https://github.com/voxpupuli/puppet-nginx/pull/32) ([lboynton](https://github.com/lboynton))
- Added listen\_options and ipv6\_listen\_options feature [\#31](https://github.com/voxpupuli/puppet-nginx/pull/31) ([guzmanbraso](https://github.com/guzmanbraso))
- Pull feature location cfg [\#29](https://github.com/voxpupuli/puppet-nginx/pull/29) ([guzmanbraso](https://github.com/guzmanbraso))
- Feature status locations [\#28](https://github.com/voxpupuli/puppet-nginx/pull/28) ([guzmanbraso](https://github.com/guzmanbraso))
- Implementation of new vars configtest\_enable and service\_restart... [\#27](https://github.com/voxpupuli/puppet-nginx/pull/27) ([guzmanbraso](https://github.com/guzmanbraso))
- Allow purge of confd dir as optional argument. [\#26](https://github.com/voxpupuli/puppet-nginx/pull/26) ([guzmanbraso](https://github.com/guzmanbraso))
- puppet-nginx refactor to class/arguments [\#25](https://github.com/voxpupuli/puppet-nginx/pull/25) ([guzmanbraso](https://github.com/guzmanbraso))
- Fixed error from cat when trying nginx.d/\* on nodes without vhosts defined [\#24](https://github.com/voxpupuli/puppet-nginx/pull/24) ([guzmanbraso](https://github.com/guzmanbraso))
- Fix issue \#22 [\#23](https://github.com/voxpupuli/puppet-nginx/pull/23) ([guilherme](https://github.com/guilherme))
- Server name array [\#19](https://github.com/voxpupuli/puppet-nginx/pull/19) ([lboynton](https://github.com/lboynton))
- Comparison operations in nginx.conf.erb template look misplaced. [\#18](https://github.com/voxpupuli/puppet-nginx/pull/18) ([rbolkey](https://github.com/rbolkey))
- Add alias support [\#17](https://github.com/voxpupuli/puppet-nginx/pull/17) ([lboynton](https://github.com/lboynton))
- Include stdlib [\#16](https://github.com/voxpupuli/puppet-nginx/pull/16) ([lboynton](https://github.com/lboynton))
-  add an array parameter to resource::vhost, server\_name [\#15](https://github.com/voxpupuli/puppet-nginx/pull/15) ([dhutty](https://github.com/dhutty))
- support operatingsystem RedHat [\#14](https://github.com/voxpupuli/puppet-nginx/pull/14) ([brettporter](https://github.com/brettporter))
- This is part of patch-1! [\#13](https://github.com/voxpupuli/puppet-nginx/pull/13) ([drdla](https://github.com/drdla))
- This is part of patch-1! [\#12](https://github.com/voxpupuli/puppet-nginx/pull/12) ([drdla](https://github.com/drdla))
- Add parameter to rewrite www to non-www [\#11](https://github.com/voxpupuli/puppet-nginx/pull/11) ([drdla](https://github.com/drdla))
- Fixed typo \(missing , at end of line\) [\#10](https://github.com/voxpupuli/puppet-nginx/pull/10) ([drdla](https://github.com/drdla))
- removed remainder of merge conflict [\#9](https://github.com/voxpupuli/puppet-nginx/pull/9) ([drdla](https://github.com/drdla))
- Fixed typo \(missing , at end of line\) [\#8](https://github.com/voxpupuli/puppet-nginx/pull/8) ([drdla](https://github.com/drdla))
- Fix small typo in variable name [\#4](https://github.com/voxpupuli/puppet-nginx/pull/4) ([luxflux](https://github.com/luxflux))
- Fixed broken README markdown. [\#1](https://github.com/voxpupuli/puppet-nginx/pull/1) ([Frost](https://github.com/Frost))

## [show](https://github.com/voxpupuli/puppet-nginx/tree/show) (2011-06-07)

[Full Changelog](https://github.com/voxpupuli/puppet-nginx/compare/v0.0.1...show)

## [v0.0.1](https://github.com/voxpupuli/puppet-nginx/tree/v0.0.1) (2011-06-07)

[Full Changelog](https://github.com/voxpupuli/puppet-nginx/compare/5d496f29e82632d391ec7b644026f585be94fec8...v0.0.1)


\* *This Changelog was automatically generated by [github_changelog_generator](https://github.com/github-changelog-generator/github-changelog-generator)*
