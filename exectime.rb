def my_min(arr)
    min = arr[0]
    arr.each do |ele1|
        arr.each do |ele2|
            if ele1 < ele2
                if min > ele1
                    min = ele1
                end
            end
        end
    end
    min
end

def my_min_better(arr)
    min = arr[0]
    arr.each do |ele|
        min = ele if ele < min
    end
    min
end


# list = [ 0, 3, 5, 4, -5, 10, 1, 90 ]
# puts my_min_better(list)  # =>  -5


def largest_contig_sum(list)
    sub_arr = []
    #n factorial O(n3)
    list.each_with_index do |ele1, idx1|
        list.each_with_index do |ele2, idx2|
            if idx2 >= idx1
                sub_arr << list[idx1..idx2]
            end
        end
    end
    #n! + n + n!*n
    sums_sub_arr = sub_arr.map {|sub_arr| sub_arr.sum}
    sums_sub_arr.max #n
end


def largest_contig_sum_better(list)
    largest_sum = -1*Float::INFINITY #or list.shift
    current_sum = list[0] #largest_sum
    list.each_with_index do |ele, i|
        if i != 0 #then we wouldnt need this
            if largest_sum < current_sum
                largest_sum = current_sum
            end

            current_sum += ele

            current_sum = ele if current_sum < ele
        end
    end
    [largest_sum,current_sum].max
end


def largest_contiguous_subsum2(arr)
    largest = arr.first
    current = arr.first

    (1...arr.length).each do |i|
      current = 0 if current < 0
      current += arr[i]
      largest = current if current > largest
    end

    largest
end

require "Set"
def first_anagram?(str1, str2)
    permutation_str1_arr = str1.split("").permutation(str1.length).to_a #n!

    permutation_joined = permutation_str1_arr.map {|permutation| permutation.join("")}

    permutation_joined.include?(str2) #n!
    #time complexity: n! + n! = n!
    #space complexity: n!

end


# p first_anagram?("gizmo", "sally")    #=> false
# p first_anagram?("elvis", "lives")    #=> true


#for negative numbers
# largest_sum = really small number
# current_sum = list[0]
# (1...list.size).each do |ele, i|
#     if largest_sum < current_sum
#         largest_sum = current_sum
#     end

#     current_sum += ele

#     current_sum = ele if current_sum < ele
# end
# return max of both numbers


# list = [5, 3, -7]
# p largest_contig_sum_better(list) # => 8

# list = [2, 3, -6, 7, -6, 7]
# p largest_contig_sum_better(list) # => 8 (from [7, -6, 7])

# list = [-5, -1, -3]
# p largest_contiguous_subsum2(list) # => -1 (from [-1])

def second_anagram?(str1, str2)
    str2_copy = str2.dup.split("")
    str1.each_char.with_index do |c, i|
        index2 = str2_copy.find_index(c)
        if index2 == nil
            return false
        else
            str2_copy[index2] = ""
        end
    end
    return str2_copy.join("") == ""
end

# p second_anagram?("gizmo", "sally")    #=> false
# p second_anagram?("elvis", "lives")    #=> true

def third_anagram?(str1, str2)
    str1_sorted = str1.split("").sort
    str2_sorted = str2.split("").sort
    str1_sorted == str2_sorted
end

# p third_anagram?("gizmo", "sally")    #=> false
# p third_anagram?("elvis", "lives")    #=> true


def fourth_anagram?(str1,str2)
    str1_hash = Hash.new(0)
    str2_hash = Hash.new(0)

    str1.each_char do |c|
        str1_hash[c] += 1
    end

    str2.each_char do |c|
        str2_hash[c] += 1
    end

    str1_hash == str2_hash
end


def fourth_anagram_b?(str1,str2)
    str_hash = Hash.new(0)


    str1.each_char do |c|
        str_hash[c] += 1
    end

    str2.each_char do |c|
        str_hash[c] -= 1
    end

    str_hash.all?{|k,v| v ==0 }
end

# p fourth_anagram_b?("gizmo", "sally")    #=> false
# p fourth_anagram_b?("elvis", "lives")    #=> true

#brute force ---- n! Wait, isn't this n^2?
def two_sum_bf?(arr, target_sum)
    sums = []
    arr.each_with_index do |ele1, i|
        arr.each_with_index do |ele2, j|
            if j > i
                sums << ele1 + ele2
            end
        end
    end
    sums.include?(target_sum)
end

#hash_map
# n
def two_sum_map?(arr, target_sum)
    set = Set.new
    arr.each do |ele1|
        comp = target_sum - ele1
        if set.include?(comp)
            return true
        end
        set.add(ele1)
    end
    false
end

def two_sum_sort?(arr, target_sum)
    sorted_arr = ms(arr)
    arr.each do |ele|
        comp = target_sum - ele
        return true if b_search(sorted_arr, comp)
    end

    false
end


def ms(arr)
    return arr if arr.length <= 1
    mid = arr.length / 2
    left = arr.take(mid)
    right = arr.drop(mid)

    sorted_left = ms(left)
    sorted_right = ms(right)

    merge!(sorted_left , sorted_right)
end


def merge!(arr1, arr2)
    new_arr = []
    until arr1.empty? || arr2.empty?
        case arr1.first <=> arr2.first
        when 1
            new_arr << arr2.shift
        when 0
            new_arr << arr1.shift
        when -1
            new_arr << arr1.shift
        end
    end
    new_arr.cooncat(arr1)
    new_arr.cooncat(arr2)
end


# n^2
def two_sum?(arr, target_sum)
    arr.each do |ele1|
        comp = target_sum - ele1
        if arr.include?(comp)
            return true
        end
    end
    false
end

#set
#underlying strcuture: we create an array of big ass number size
#store number in one of the indexes
#include? we check at that set to see if the number exists
# arr[i] if the number exists

# arr = [0, 1, 5, 7]
# p two_sum_map?(arr, 6) # => should be true
# p two_sum_map?(arr, 10) # => should be false


# O(N - window_size) => O(N)
def windowed_max_range(array, window_size)
    current_max_range = nil
    max_diff = 0
    i = 0
    while i <= array.length - window_size #O(n)
        window = array[i...i+window_size] #new class would go to this
        min, max = window.min, window.max #K for window size. O(K) 2*k bc we searched it twice. With our new class, it should only take O(1) time
        diff = max - min
        if diff > max_diff
            max_diff = diff
            current_max_range = window
        end
        i += 1
    end #O(N*2k)
    p max_diff
    max_diff
end


class MyQueue
    def initialize
      @store = []
    end

    def peek
        @store[0]
    end

    def size
        @store.length
    end

    def empty
        @store.empty?
    end

    def enqueue(item)
        @store << item
    end

    def dequeue
        @store.shift
    end
end
myQueue = MyQueue.new
arr = [1, 0, 2, 5, 4, 8]
until arr.empty?
    myQueue.enqueue(arr.shift)
end
# p myQueue.size
# p myQueue

class MyStack
    def initialize(arr = nil)
        @stack = arr
    end

    def push(item)
        @stack << item
    end

    def pop
        @stack.pop
    end

    def peek
        @stack[-1]
    end

    def size
        @stack.length
    end

    def empty?
        @stack.empty?
    end
end

class StackQueue

    def initialize(arr1)
        @stack1 = MyStack.new(arr1)  #window
        @stack2 = MyStack.new([])  #remaining
        # @max = nil
        # @min = nil
    end

    def size
        @stack1.size + @stack2.size
    end

    def empty?
        @stack1.empty? and @stack2.empty?
    end

    def enqueue(item)
        # @max = [item,@max].max
        # @min = [item,@min].min
        @stack1.push(item)
    end

    def dequeue
        if @stack2.empty? and @stack1.size > 0
            until @stack1.empty?
                item = @stack1.pop
                # unless @stack1.size == 0
                #     @max = [item,@max].max
                #     @min = [item,@min].min
                # end
                @stack2.push(item)
            end
        end
        @stack2.pop
    end

    # def max
    #     @max
    # end

    # def min
    #     @min
    # end

end

class MinMaxStack
    def initialize(arr)
        @store = []
        @min_stack = []
        @max_stack = []
        arr_copy = arr.dup
        until arr_copy.empty?
            self.push(arr_copy.shift)
        end
    end

    def push(item)
        @store << item
        if @min_stack.empty?
            @min_stack << item
        end
        if @max_stack.empty?
            @max_stack << item
        end
        if item <= @min_stack[-1]
            @min_stack << item
        end
        if item >= @max_stack[-1]
            @max_stack << item
        end
    end

    def pop
        item = @stack.pop
        if item == @min_stack[-1]
            @min_stack.pop
        end
        if item == @max_stack[-1]
            @max_stack.pop
        end
        item
    end

    def peek
        @store[-1]
    end

    def size
        @store.length
    end

    def empty?
        @store.empty?
    end

    def max
        @max_stack[-1]
    end

    def min
        @min_stack[-1]
    end
end

class MinMaxStackQueue

    def initialize(arr1)
        @stack1 = MinMaxStack.new(arr1)  #window
        @stack2 = MinMaxStack.new([])  #remaining
        @max = @stack1.max
        @min = @stack1.min
    end

    def size
        @stack1.size + @stack2.size
    end

    def empty?
        @stack1.empty? and @stack2.empty?
    end

    def enqueue(item)
        @stack1.push(item)
        @max = [@stack1.max, @stack2.max].max
        @min = [@stack2.min, @stack1.min].min
    end

    def dequeue
        if @stack2.empty? and @stack1.size > 0
            until @stack1.empty?
                item = @stack1.pop
                unless @stack1.size == 0
                    @max = @stack2.max
                    @min = @stack2.min
                end
                @stack2.push(item)
            end
        end
        @stack2.pop
    end

    def max
        return -1 if @stack1.max.nil? and @stack2.max.nil?
        return @stack1.max if @stack2.max.nil? and !@stack1.max.nil?
        return @stack2.max if !@stack2.max.nil? and @stack1.max.nil?
        [@stack1.max, @stack2.max].max
    end

    def min
        return -1 if @stack1.min.nil? and @stack2.min.nil?
        return @stack1.min if @stack2.min.nil? and !@stack1.min.nil?
        return @stack2.min if !@stack2.min.nil? and @stack1.min.nil?
        [@stack1.min, @stack2.min].min
    end

end

def windowed_max_range_new_and_improved(array, window_size)
    current_max_range = nil
    max_diff = 0
    i = 0
    while i <= array.length - window_size #O(n)
        window = MinMaxStackQueue.new(array[i...i+window_size]) #new class would go to this
        min, max = window.min, window.max #K for window size. O(K) 2*k bc we searched it twice. With our new class, it should only take O(1) time
        diff = max - min
        if diff > max_diff
            max_diff = diff
            current_max_range = window
        end
        i += 1
    end #O(N*2k)
    p max_diff
    max_diff
end













windowed_max_range([1, 0, 2, 5, 4, 8], 2) == 4 # 4, 8
arr1 = [1, 0, 2, 5, 4, 8]
window = []
stack1 = StackQueue.new(arr1)





# p windowed_max_range([1, 0, 2, 5, 4, 8], 2) == 4 # 4, 8
# p windowed_max_range([1, 0, 2, 5, 4, 8], 3) == 5 # 0, 2, 5
# p windowed_max_range([1, 0, 2, 5, 4, 8], 4) == 6 # 2, 5, 4, 8
# p windowed_max_range([1, 3, 2, 5, 4, 8], 5) == 6 # 3, 2, 5, 4, 8
