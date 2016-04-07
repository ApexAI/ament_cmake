# Copyright 2015 Open Source Robotics Foundation, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#
# Check if the index contains a specific resource.
#
# :param var: the flag if the requested resource exists
# :type var: boolean flag
# :param resource_type: the type of the resource
# :type resource_type: string
# :param resource_name: the name of the resource
# :type resource_name: string
#
# @public
#
function(ament_index_has_resource var resource_type resource_name)
  if("${resource_type} " STREQUAL " ")
    message(FATAL_ERROR
      "ament_index_has_resource() called without a 'resource_type'")
  endif()
  if("${resource_name} " STREQUAL " ")
    message(FATAL_ERROR
      "ament_index_has_resource() called without a 'resource_name'")
  endif()

  if(NOT "${ARGN} " STREQUAL " ")
    message(FATAL_ERROR "ament_index_has_resource() called with unused "
      "arguments: ${ARGN}")
  endif()

  ament_index_get_prefix_path(paths_to_search)
  set(retval FALSE)
  foreach(path IN LISTS paths_to_search)
    if(EXISTS
        "${path}/share/ament_index/resource_index/${resource_type}/${resource_name}")
      set(retval TRUE)
      break()
    endif()
  endforeach()
  set(${var} "${retval}" PARENT_SCOPE)
endfunction()
