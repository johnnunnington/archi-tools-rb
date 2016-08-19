module Archimate
  module Cli
    require "thor"

    class Archimate < Thor
      desc "map ARCHIFILE", "EXPERIMENTAL: Produce a map of diagram links to a diagram"
      def map(archifile)
        Archimate::Mapper.new.map(archifile)
      end

      desc "merge ARCHIFILE1 ARCHIFILE2", "EXPERIMENTAL: Merge two archimate files"
      def merge(archifile1, archifile2)
        Archimate::Merger.new.merge_files(archifile1, archifile2)
      end

      desc "project ARCHIFILE PROJECTFILE", "EXPERIMENTAL: Synchronize an Archi file and an MSProject XML file"
      def project(archifile, projectfile)
        Archimate::Projector.new.project(archifile, projectfile)
      end

      desc "svg ARCHIFILE", "IN DEVELOPMENT: Produce semantically meaningful SVG files from an Archi file"
      def svg(archifile)
        Archimate::Svger.new.make_svgs(archifile)
      end

      desc "dupes ARCHIFILE", "List all duplicate elements in Archi file"
      def dupes(archifile)
        Archimate::Duper.new.list_dupes(archifile)
      end

      desc "clean ARCHIFILE", "Clean up unreferenced elements and relations"
      option :output,
             aliases: :o,
             desc: "Write output to FILE instead of replacing ARCHIFILE"
      option :saveremoved,
             aliases: :r,
             desc: "Write removed elements into FILE"
      def clean(archifile)
        outfile = options.delete(:output) || archifile
        Archimate::MaybeIO(options.delete(:saveremoved)) do |removed_element_io|
          Archimate::Cleanup.new(archifile, outfile, removed_element_io)
        end
      end

      desc "dedupe ARCHIFILE", "de-duplicate elements in Archi file"
      option :mergeall,
             aliases: :m,\
             type: :boolean,
             desc: "Merges all duplicates without asking"
      option :output,
             aliases: :o,
             desc: "Write output to FILE instead of replacing ARCHIFILE"
      option :force,
             aliases: :f,
             type: :boolean,
             desc: "Force overwriting of existing output file"
      def dedupe(archifile)
        Archimate::Duper.new.merge({ archifile: archifile, output: archifile }.merge(options))
      end

      desc "convert ARCHIFILE", "Convert the incoming file to the desired type"
      option :to,
             aliases: :t,\
             default: Archimate::Convert::SUPPORTED_FORMATS.first,
             desc: "File type to convert to. Options are: " \
                   "'meff2.1' for Open Group Model Exchange File Format for ArchiMate 2.1 " \
                   "'archi' for Archi http://archimatetool.com/ file format " \
                   "'nquads' for RDF 1.1 N-Quads format https://www.w3.org/TR/n-quads/",
             enum: Archimate::Convert::SUPPORTED_FORMATS
      option :output,
             aliases: :o,
             desc: "Write output to FILE instead of stdout."
      option :force,
             aliases: :f,
             type: :boolean,
             desc: "Force overwriting of existing output file"
      def convert(archifile)
        Archimate::Document.output_io(options) do |output|
          Archimate::Convert.new.convert(archifile, output, options)
        end
      end
    end
  end
end
