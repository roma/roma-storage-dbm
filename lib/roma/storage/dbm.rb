require "roma/storage/dbm/version"

require 'gdbm'
require 'roma/storage/basic_storage'

module Roma
  module Storage

    module GDBM_Ext
      def put(k,v); self[k] = v; end
      def get(k); self[k]; end
      def out(k); delete(k); end
      def rnum; length; end
    end

    class DbmStorage < BasicStorage

      def initialize
        super
        @ext_name = 'dbm'
      end

      # Yields the keys that the database has when it starts: deleting a key
      # while GDBM iterates may skip others. A key deleted meanwhile is
      # skipped.
      def each_record(hdb)
        hdb.keys.each do |k|
          v = hdb[k]
          yield k, v if v
        end
      end

      private

      def open_db(fname)
        hdb = GDBM::open(fname,0666)
        raise RuntimeError.new("dbm open error.") unless hdb
        hdb.extend(Roma::Storage::GDBM_Ext)
        return hdb
      end

      def close_db(hdb); hdb.close; end

    end # class DbmStorage

  end # module Storage
end # module Roma