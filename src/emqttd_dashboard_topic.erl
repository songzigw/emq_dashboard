%%--------------------------------------------------------------------
%% Copyright (c) 2015-2016 Feng Lee <feng@emqtt.io>.
%%
%% Licensed under the Apache License, Version 2.0 (the "License");
%% you may not use this file except in compliance with the License.
%% You may obtain a copy of the License at
%%
%%     http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing, software
%% distributed under the License is distributed on an "AS IS" BASIS,
%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%% See the License for the specific language governing permissions and
%% limitations under the License.
%%--------------------------------------------------------------------

%% @doc Action for topic api.
-module(emqttd_dashboard_topic).

-include("emqttd_dashboard.hrl").
-include("../../../include/emqttd.hrl").

-include_lib("stdlib/include/qlc.hrl").

-export([execute/0]).

execute() ->
    %% Count total number.
    F = fun() -> qlc:e(qlc:q([E || E <- mnesia:table(topic)])) end,
    {atomic, Topics} =  mnesia:transaction(F),
    [[{topic, Topic}, {flags, Flags}] || #mqtt_topic{topic = Topic,flags= Flags} <- Topics].
